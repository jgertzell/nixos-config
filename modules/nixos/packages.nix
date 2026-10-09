{ inputs, pkgs, ... }:

let
  dotnetPkgs = import inputs.dotnet-nixpkgs {
    system = pkgs.stdenv.hostPlatform.system;
    config.permittedInsecurePackages = [
      "aspnetcore-runtime-6.0.36"
      "aspnetcore-runtime-7.0.20"
      "aspnetcore-runtime-wrapped-6.0.36"
      "aspnetcore-runtime-wrapped-7.0.20"
      "dotnet-runtime-6.0.36"
      "dotnet-runtime-7.0.20"
      "dotnet-runtime-wrapped-6.0.36"
      "dotnet-runtime-wrapped-7.0.20"
      "dotnet-sdk-6.0.428"
      "dotnet-sdk-7.0.410"
      "dotnet-sdk-wrapped-6.0.428"
      "dotnet-sdk-wrapped-7.0.410"
    ];
  };
  dotnet = dotnetPkgs.dotnetCorePackages.combinePackages (with dotnetPkgs.dotnetCorePackages; [
    sdk_6_0
    sdk_7_0
    sdk_8_0
    sdk_9_0
    sdk_10_0
    aspnetcore_6_0
    aspnetcore_7_0
    aspnetcore_8_0
    aspnetcore_9_0
    aspnetcore_10_0
  ]);

  azureCli = pkgs.azure-cli.withExtensions (with pkgs.azure-cli-extensions; [
    application-insights
    log-analytics
  ]);

  installAzPowerShell = pkgs.writeShellScriptBin "install-az-powershell" ''
    exec ${pkgs.powershell}/bin/pwsh -NoLogo -NoProfile -Command '
      Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
      Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber
    '
  '';

  installDotnetTools = pkgs.writeShellScriptBin "install-dotnet-tools" ''
    set -eu

    export DOTNET_ROOT=${dotnet}/share/dotnet
    export PATH="$HOME/.dotnet/tools:$PATH"

    ${dotnet}/bin/dotnet tool update --global EasyDotnet || ${dotnet}/bin/dotnet tool install --global EasyDotnet
    ${dotnet}/bin/dotnet tool update --global dotnet-ef || ${dotnet}/bin/dotnet tool install --global dotnet-ef
    ${dotnet}/bin/dotnet tool update --global Aspire.Cli --prerelease || ${dotnet}/bin/dotnet tool install --global Aspire.Cli --prerelease
  '';

  installArtifactsCredProvider = pkgs.writeShellScriptBin "install-artifacts-credprovider" ''
    set -eu

    tmp=$(mktemp -d)
    trap 'rm -rf "$tmp"' EXIT

    ${pkgs.curl}/bin/curl --fail --location --silent --show-error \
      --output "$tmp/installcredprovider.sh" \
      https://github.com/microsoft/artifacts-credprovider/releases/latest/download/installcredprovider.sh

    ${pkgs.bash}/bin/bash "$tmp/installcredprovider.sh"
  '';
in

{
  environment.variables = {
    DOTNET_ROOT = "${dotnet}/share/dotnet";
    DOTNET_ROOT_X64 = "${dotnet}/share/dotnet";
  };

  environment.systemPackages = with pkgs; [
    vim
    btop
    kitty
    firefox
    chromium
    obs-studio
    moonlight-qt
    remmina
    libreoffice
    vlc
    freecad
    openscad
    prusa-slicer
    android-file-transfer
    gvfs
    glib
    libmtp
    usbutils
    networkmanagerapplet
    networkmanager-openvpn
    openvpn
    proton-vpn
    wireguard-tools
    thunar
    thunar-volman
    thunar-archive-plugin
    file-roller
    zip
    unzip
    p7zip
    unar
    tumbler
    git
    git-lfs
    libsecret
    seahorse
    xdg-utils
    wl-clipboard
    rofi
    grim
    slurp
    swappy
    waybar
    vscode
    powershell
    lazygit
    azureCli
    azure-functions-core-tools
    jq
    jd-diff-patch
    nodejs
    sqlite
    duckdb
    docker-compose
    icu
    openssl
    nss
    dotnet
    roslyn-ls
    netcoredbg
    vscode-langservers-extracted
    installAzPowerShell
    installDotnetTools
    installArtifactsCredProvider
    terraform
  ];
}

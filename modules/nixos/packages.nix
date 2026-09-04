{ pkgs, ... }:

let
  dotnet = pkgs.dotnetCorePackages.combinePackages (with pkgs.dotnetCorePackages; [
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
  environment.systemPackages = with pkgs; [
    vim
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
    simple-mtpfs
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

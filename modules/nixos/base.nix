{ pkgs, username, hostname, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = hostname;
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [ networkmanager-openvpn ];
  };
  networking.wireless.enable = true;

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };
  console.keyMap = "sv-latin1";

  environment.shells = [ pkgs.fish pkgs.nushell pkgs.xonsh ];
  programs.fish.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      curl
      glib
      icu
      krb5
      libsecret
      openssl
      stdenv.cc.cc
      zlib
    ];
  };

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "adbusers" "dialout" "docker" "libvirtd" "networkmanager" "plugdev" "wheel" ];
    packages = [ ];
    shell = pkgs.fish;
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
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
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
  };

  system.stateVersion = "26.05";
}

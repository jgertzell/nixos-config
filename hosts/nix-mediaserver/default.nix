{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./media-server.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/desktop-hyprland.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/packages.nix
  ];
}

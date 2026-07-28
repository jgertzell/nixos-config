{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./laptop.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/desktop-hyprland.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/packages.nix
  ];
}

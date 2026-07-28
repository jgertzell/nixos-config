{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/desktop-hyprland.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/hardware.nix
    ../../modules/nixos/packages.nix
  ];
}

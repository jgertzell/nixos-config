# PLACEHOLDER!!
{ lib, ... }:

{
  fileSystems."/" = {
    device = "/dev/disk/by-label/REPLACE-ME";
    fsType = "ext4";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}

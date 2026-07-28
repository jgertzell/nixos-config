{ config, pkgs, ... }:

{
  home.packages = [ pkgs.kitty ];

  xdg.configFile."kitty".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/kitty";
}

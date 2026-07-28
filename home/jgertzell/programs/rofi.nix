{ config, pkgs, ... }:

{
  home.packages = [ pkgs.rofi ];

  xdg.configFile."rofi/config.rasi".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/rofi/config.rasi";
}

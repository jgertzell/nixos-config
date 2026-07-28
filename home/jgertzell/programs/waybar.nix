{ config, ... }:

{
  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/waybar";

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "graphical-session.target" ];
    };
  };
}

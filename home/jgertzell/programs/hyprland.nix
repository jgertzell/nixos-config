{ config, ... }:

{
  home.file.".config/hypr/hyprland.lua" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/hypr/hyprland.lua";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
  };
}

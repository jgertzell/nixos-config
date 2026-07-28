{ config, lib, pkgs, ... }:

let
  keybinds = import ./hyprland-keybind-data.nix;

  keybindRow = bind:
    if bind.separator or false then
      "    (separator)"
    else
      ''    (keybind_row :keys "${bind.shortKeys}" :action "${bind.shortAction}")'';

  keybindRows = lib.concatStringsSep "\n" (map keybindRow keybinds);
in

{
  home.packages = [ pkgs.eww ];

  # Keybind rows are derived from the shared Hyprland keybind data.
  home.file.".config/eww/keybinds.yuck".text = ''
    (defwidget keybind_rows []
      (box :orientation "vertical"
           :space-evenly false
${keybindRows}
      ))
  '';

  xdg.configFile."eww/eww.yuck".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/eww/eww.yuck";
  xdg.configFile."eww/eww.scss".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/eww/eww.scss";
  xdg.configFile."eww/eww-scale.scss".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/eww/eww-scale.scss";
}

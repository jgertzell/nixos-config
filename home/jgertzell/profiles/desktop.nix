{ pkgs, ... }:

{
  home.packages = [
    pkgs.tesseract
    (pkgs.writeShellScriptBin "ocr-clipboard" ''
      set -o pipefail
      ${pkgs.wl-clipboard}/bin/wl-paste --type image/png | ${pkgs.tesseract}/bin/tesseract stdin stdout "$@"
    '')
  ];

  imports = [
    ../programs/dunst.nix
    ../programs/eww.nix
    ../programs/firefox.nix
    ../programs/gnome-keyring.nix
    ../programs/gtk.nix
    ../programs/hyprland.nix
    ../programs/hyprland-keybinds.nix
    ../programs/hypridle.nix
    ../programs/kanshi.nix
    ../programs/kitty.nix
    ../programs/protonvpn.nix
    ../programs/rofi.nix
    ../programs/thunar.nix
    ../programs/waybar.nix
  ];
}

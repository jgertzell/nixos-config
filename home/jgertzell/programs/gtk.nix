{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    adwaita-icon-theme
    bibata-cursors
    adw-gtk3
    papirus-icon-theme
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = false;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  xdg.configFile."gtk-3.0/settings.ini".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/gtk-3.0/settings.ini";
  xdg.configFile."gtk-4.0/settings.ini".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/gtk-4.0/settings.ini";

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Bibata-Modern-Classic";
      cursor-size = 24;
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "Papirus-Dark";
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Bibata-Modern-Classic";
    HYPRCURSOR_SIZE = "24";
  };
}

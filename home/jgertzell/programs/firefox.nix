{ config, ... }:

{
  xdg.dataFile."applications/firefox-profile-manager.desktop".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/applications/firefox-profile-manager.desktop";
  xdg.configFile."mimeapps.list".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/mimeapps.list";
}

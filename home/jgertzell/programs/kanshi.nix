{ config, ... }:

{
  services.kanshi.enable = true;

  xdg.configFile."kanshi".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/kanshi";
}

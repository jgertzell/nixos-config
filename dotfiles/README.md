# Dotfiles

Place user-editable application configuration here. Home Manager links these files directly from `/etc/nixos/dotfiles`, so editing them does not require a rebuild.

Example:

```nix
xdg.configFile."kitty".source =
  config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/kitty";
```

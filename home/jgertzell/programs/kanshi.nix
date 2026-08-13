{ config, ... }:

{
  services.kanshi.enable = true;

  # UWSM can take several seconds to recreate the Wayland socket after
  # Hyprland exits. Avoid exhausting systemd's default rapid-restart limit.
  systemd.user.services.kanshi = {
    Unit = {
      StartLimitBurst = 10;
      StartLimitIntervalSec = 30;
    };
    Service.RestartSec = 2;
  };

  xdg.configFile."kanshi".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/kanshi";
}

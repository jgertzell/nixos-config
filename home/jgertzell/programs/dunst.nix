{ config, pkgs, ... }:

{
  systemd.user.services.low-battery-notify = {
    Unit.Description = "Notify when battery is low";
    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "low-battery-notify" ''
        set -eu

        for battery in /sys/class/power_supply/BAT*; do
          [ -d "$battery" ] || continue

          IFS= read -r capacity < "$battery/capacity"
          IFS= read -r status < "$battery/status"

          if [ "$status" = "Discharging" ] && [ "$capacity" -le 15 ]; then
            if [ "$capacity" -le 10 ]; then
              urgency=critical
              message="Battery is at ''${capacity}%. Suspending soon."
            else
              urgency=normal
              message="Battery is at ''${capacity}%. Plug in soon."
            fi

            ${pkgs.libnotify}/bin/notify-send \
              --app-name="Battery" \
              --urgency="$urgency" \
              --replace-id=9505 \
              "Low battery" \
              "$message"
          fi
        done
      '';
    };
  };

  systemd.user.timers.low-battery-notify = {
    Unit.Description = "Check battery level for low battery notifications";
    Timer = {
      OnBootSec = "1min";
      OnUnitActiveSec = "2min";
      AccuracySec = "30s";
    };
    Install.WantedBy = [ "timers.target" ];
  };

  home.packages = [ pkgs.dunst ];

  xdg.dataFile."dbus-1/services/org.knopwob.dunst.service".source =
    "${pkgs.dunst}/share/dbus-1/services/org.knopwob.dunst.service";

  systemd.user.services.dunst = {
    Unit = {
      Description = "Dunst notification daemon";
      After = [ config.wayland.systemd.target ];
      PartOf = [ config.wayland.systemd.target ];
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${pkgs.dunst}/bin/dunst";
      ExecReload = "${pkgs.dunst}/bin/dunstctl reload";
    };
  };

  xdg.configFile."dunst/dunstrc".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/dunst/dunstrc";
}

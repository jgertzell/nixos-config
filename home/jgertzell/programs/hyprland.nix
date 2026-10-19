{ config, pkgs, ... }:

{
  home.file.".config/hypr/hyprland.lua" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/hypr/hyprland.lua";
  };

  home.file.".local/bin/hyprland-enable-edp" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -u

      hyprctl=${pkgs.hyprland}/bin/hyprctl
      socat=${pkgs.socat}/bin/socat

      while true; do
        if [[ -z "''${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
          sleep 1
          continue
        fi

        socket="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
        if [[ ! -S "$socket" ]]; then
          sleep 1
          continue
        fi

        "$socat" -u "UNIX-CONNECT:$socket" - | while IFS= read -r event; do
          case "$event" in
            monitorremoved\>\>eDP-1) ;;
            monitorremoved\>\>*)
              # kanshi can wait forever for a failed output-management transaction.
              sleep 1
              "$hyprctl" keyword monitor "eDP-1,preferred,0x0,1"
              ;;
          esac
        done

        sleep 1
      done
    '';
  };

  systemd.user.services.hyprland-enable-edp = {
    Unit = {
      Description = "Enable the laptop panel after external monitor removal";
      ConditionEnvironment = "XDG_CURRENT_DESKTOP=Hyprland";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "%h/.local/bin/hyprland-enable-edp";
      Restart = "always";
      RestartSec = 1;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
  };
}

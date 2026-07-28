{ config, pkgs, ... }:

let
  gatewayConnection = "ProtonVPN FO-PROTON-GW#1";
in

{
  xdg.configFile."autostart/protonvpn-app.desktop".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/autostart/protonvpn-app.desktop";

  systemd.user.services.protonvpn-connect = {
    Unit = {
      Description = "Connect to ${gatewayConnection}";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "protonvpn-connect" ''
        set -eu

        for _ in $(seq 1 12); do
          if ${pkgs.networkmanager}/bin/nmcli --terse --fields NAME connection show | ${pkgs.gnugrep}/bin/grep -Fxq ${pkgs.lib.escapeShellArg gatewayConnection}; then
            exec ${pkgs.networkmanager}/bin/nmcli connection up ${pkgs.lib.escapeShellArg gatewayConnection}
          fi

          sleep 5
        done

        echo "NetworkManager connection not found: ${gatewayConnection}" >&2
        exit 1
      '';
    };

    Install.WantedBy = [ "default.target" ];
  };
}

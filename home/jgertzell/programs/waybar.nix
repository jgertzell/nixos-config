{ config, pkgs, ... }:

let
  coffeeMode = pkgs.writeShellApplication {
    name = "coffee-mode";
    runtimeInputs = [ pkgs.procps pkgs.systemd ];
    text = ''
      unit=coffee-mode.service

      case "''${1:-status}" in
        status)
          if systemctl --user --quiet is-active "$unit"; then
            printf '%s\n' '{"text":"COFFEE ON","class":"active","tooltip":"Coffee mode active: sleep and automatic locking are disabled"}'
          else
            printf '%s\n' '{"text":"COFFEE OFF","class":"inactive","tooltip":"Coffee mode inactive: click to prevent sleep and automatic locking"}'
          fi
          ;;
        toggle)
          if systemctl --user --quiet is-active "$unit"; then
            systemctl --user stop "$unit"
          else
            systemctl --user start "$unit"
          fi
          pkill -RTMIN+8 waybar || true
          ;;
        *)
          printf 'Usage: coffee-mode {status|toggle}\n' >&2
          exit 2
          ;;
      esac
    '';
  };
in
{
  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/waybar";

  home.packages = [ coffeeMode ];

  systemd.user.services.coffee-mode = {
    Unit.Description = "Prevent sleep and automatic screen locking";
    Service = {
      Type = "simple";
      ExecStartPre = "${pkgs.systemd}/bin/systemctl --user stop hypridle.service";
      ExecStart = ''
        ${pkgs.systemd}/bin/systemd-inhibit \
          --what=idle:sleep:handle-lid-switch \
          --who="Coffee mode" \
          --why="Coffee mode is active" \
          --mode=block \
          ${pkgs.coreutils}/bin/sleep infinity
      '';
      ExecStopPost = "-${pkgs.systemd}/bin/systemctl --user start hypridle.service";
    };
  };

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "graphical-session.target" ];
    };
  };
}

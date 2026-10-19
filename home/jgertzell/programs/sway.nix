{ config, lib, pkgs, ... }:

let
  swaymsg = "${pkgs.sway}/bin/swaymsg";
  lock = "${pkgs.procps}/bin/pgrep -x swaylock || ${pkgs.swaylock}/bin/swaylock -f";
in
{
  xdg.configFile."sway/config".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/sway/config";

  # UWSM sources this only for the sway session. HDR needs the Vulkan renderer.
  xdg.configFile."uwsm/env-sway".text = ''
    export WLR_RENDERER=vulkan
  '';

  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      show-failed-attempts = true;
      indicator-radius = 80;
      inside-color = "111111";
      ring-color = "777777";
      key-hl-color = "4c7899";
      text-color = "dddddd";
      line-color = "00000000";
      separator-color = "00000000";
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = lock;
      }
      {
        timeout = 600;
        command = "${swaymsg} 'output * power off'";
        resumeCommand = "${swaymsg} 'output * power on'";
      }
    ];
    events = {
      before-sleep = lock;
      lock = lock;
      after-resume = "${swaymsg} 'output * power on'";
    };
  };

  # graphical-session.target is shared with Hyprland; only run under sway.
  systemd.user.services.swayidle.Unit.ConditionEnvironment =
    lib.mkForce [ "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP=sway" ];
}

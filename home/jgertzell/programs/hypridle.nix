{ lib, pkgs, ... }:

let
  # Lua DPMS dispatchers need an action table; a string silently toggles power.
  displayOn = "${pkgs.hyprland}/bin/hyprctl dispatch 'hl.dsp.dpms({action = \"on\"})'";
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };

      background = [
        {
          color = "rgb(000000)";
        }
      ];

      label = [
        {
          text = "$TIME";
          color = "rgb(999999)";
          font_size = 48;
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
        {
          text = "Locked";
          color = "rgb(777777)";
          font_size = 16;
          position = "0, 35";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          size = "260, 50";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgb(777777)";
          inner_color = "rgb(111111)";
          font_color = "rgb(dddddd)";
          fade_on_empty = false;
          placeholder_text = "<i>Enter password</i>";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          position = "0, -35";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${pkgs.procps}/bin/pgrep -x hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "${pkgs.procps}/bin/pgrep -x hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        after_sleep_cmd = displayOn;
        on_lock_cmd = "${pkgs.systemd}/bin/systemd-run --user --unit=hyprlock-dpms --on-active=5m ${pkgs.hyprland}/bin/hyprctl dispatch 'hl.dsp.dpms({action = \"off\"})'";
        on_unlock_cmd = "${pkgs.systemd}/bin/systemctl --user stop hyprlock-dpms.timer hyprlock-dpms.service; ${displayOn}";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "${pkgs.procps}/bin/pgrep -x hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
          on-resume = displayOn;
        }
      ];
    };
  };

  # graphical-session.target is shared with sway; only run under Hyprland.
  systemd.user.services.hypridle.Unit.ConditionEnvironment =
    lib.mkForce [ "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP=Hyprland" ];
}

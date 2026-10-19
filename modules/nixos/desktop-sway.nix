{ pkgs, ... }:

{
  # Sway runs side by side with Hyprland; pick it at login with
  # `uwsm start sway-uwsm.desktop`. Portal routing comes from the sway module.
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      brightnessctl
      playerctl
      swayidle
      swaylock
    ];
  };

  programs.uwsm.waylandCompositors.sway = {
    prettyName = "Sway";
    comment = "Sway compositor managed by UWSM";
    binPath = "/run/current-system/sw/bin/sway";
  };

  security.pam.services.swaylock = { };
}

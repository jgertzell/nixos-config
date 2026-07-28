{ pkgs, ... }:

{
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower = {
    enable = true;
    usePercentageForPolicy = true;
    percentageLow = 15;
    percentageCritical = 10;
    percentageAction = 5;
    criticalPowerAction = "Suspend";
    allowRiskyCriticalPowerAction = true;
  };
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  security.rtkit.enable = true;

  boot.extraModprobeConfig = ''
    options snd_intel_dspcfg dsp_driver=1
  '';

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
    pulseaudio
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}

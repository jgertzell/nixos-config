{ config, pkgs, ... }:

{
  fileSystems."/srv/media" = {
    device = "/dev/disk/by-uuid/25c6b93a-4ebe-4454-9a28-4c406e7823b4";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  users.groups.media.gid = 1001;
  users.users.jgertzell.extraGroups = [ "media" ];

  systemd.tmpfiles.rules = [
    "d /srv/media/appdata 2775 jgertzell media -"
    "d /srv/media/backups 2775 jgertzell media -"
    "d /srv/media/appdata/compose 2770 jgertzell media -"
    "d /srv/media/library 2775 jgertzell media -"
    "d /srv/media/torrents 2775 jgertzell media -"
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
  virtualisation.oci-containers.backend = "docker";

  services.xserver.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    input.General = {
      ClassicBondedOnly = false;
      UserspaceHID = true;
    };
    settings.General = {
      ControllerMode = "dual";
      FastConnectable = true;
    };
  };
  services.blueman.enable = true;

  programs.steam.enable = true;

  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.caddy.enable = true;

  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    docker-compose
    wayland-utils
  ];

  systemd.services.mediaserver-containers = {
    description = "Mediaserver Docker Compose stack";
    wantedBy = [ "multi-user.target" ];
    after = [ "docker.service" "srv-media.mount" ];
    requires = [ "docker.service" "srv-media.mount" ];
    path = [ pkgs.docker-compose pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ConditionPathExists = "/srv/media/appdata/compose/mediaserver.env";
      WorkingDirectory = "/etc/nixos/hosts/nix-mediaserver/containers";
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose --env-file /srv/media/appdata/compose/mediaserver.env -f /etc/nixos/hosts/nix-mediaserver/containers/compose.yml up -d";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose --env-file /srv/media/appdata/compose/mediaserver.env -f /etc/nixos/hosts/nix-mediaserver/containers/compose.yml down";
      TimeoutStartSec = "15min";
      TimeoutStopSec = "5min";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 8080 8096 ];
    trustedInterfaces = [ "tailscale0" ];
  };
}

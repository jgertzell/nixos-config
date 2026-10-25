{ config, pkgs, ... }:

let
  checkUpdates = pkgs.writeShellApplication {
    name = "nixos-check-updates";
    runtimeInputs = [ pkgs.nix pkgs.jq pkgs.libnotify pkgs.coreutils ];
    text = ''
      flake=$(realpath -e "''${1:-/etc/nixos}")
      tmp=$(mktemp -d)
      trap 'rm -rf "$tmp"' EXIT

      # Keep both the baseline and the proposed lock outside the repository.
      cp "$flake/flake.lock" "$tmp/current.lock"
      nix flake update --refresh --flake "$flake" \
        --reference-lock-file "$tmp/current.lock" \
        --output-lock-file "$tmp/updated.lock"

      changed=$(jq --raw-output --slurpfile current "$tmp/current.lock" '
        [.nodes | to_entries[]
          | select(.value.locked != null)
          | select(.value.locked != $current[0].nodes[.key].locked)
          | .key] | join(", ")
      ' "$tmp/updated.lock")

      if [ -z "$changed" ]; then
        printf '%s\n' 'Flake inputs are up to date.'
        exit 0
      fi

      printf 'Updates available: %s\n' "$changed"
      notify-send --app-name="NixOS updates" --urgency=normal \
        --hint=string:x-dunst-stack-tag:nixos-updates \
        "NixOS updates available" \
        "New flake inputs: $changed. Review with nix flake update, then nh os switch."
    '';
  };
in
{
  home.packages = [ checkUpdates ];

  systemd.user.services.nixos-update-check = {
    Unit = {
      Description = "Check for flake updates without applying them";
      After = [ config.wayland.systemd.target ];
      Requisite = [ config.wayland.systemd.target ];
      PartOf = [ config.wayland.systemd.target ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${checkUpdates}/bin/nixos-check-updates";
      TimeoutStartSec = "10min";
    };
  };

  systemd.user.timers.nixos-update-check = {
    Unit = {
      Description = "Daily notification-only NixOS update check";
      PartOf = [ config.wayland.systemd.target ];
    };
    Timer = {
      OnActiveSec = "10min";
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "30min";
    };
    Install.WantedBy = [ config.wayland.systemd.target ];
  };
}

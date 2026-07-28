{ lib, pkgs, ... }:

let
  keybinds = builtins.filter (bind: !(bind.separator or false)) (import ./hyprland-keybind-data.nix);

  row = bind: lib.concatStringsSep "\t" [ bind.keys bind.action bind.command ];
in
{
  home.file.".local/share/hyprland/keybinds.tsv".text =
    lib.concatStringsSep "\n" ([ "keys\taction\tcommand" ] ++ map row keybinds) + "\n";

  home.file.".local/bin/hyprland-keybinds" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      keybinds="$HOME/.local/share/hyprland/keybinds.tsv"

      if [[ ! -f "$keybinds" ]]; then
        rofi -e "Missing keybind file: $keybinds"
        exit 1
      fi

      awk -F '\t' 'NR > 1 { printf "%-28s %s\n", $1, $2 }' "$keybinds" \
        | rofi -dmenu -i -p "Keybinds" -no-custom \
            -theme sidebar \
            -theme-str 'window { width: 760px; }' \
            -theme-str 'listview { lines: 18; }'
    '';
  };

  home.file.".local/bin/hyprland-keybinds-open" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      eww=${pkgs.eww}/bin/eww
      hyprctl=${pkgs.hyprland}/bin/hyprctl
      python=${pkgs.python3}/bin/python3

      if ! "$eww" --force-wayland ping >/dev/null 2>&1; then
        "$eww" --force-wayland daemon
        for _ in {1..20}; do
          "$eww" --force-wayland ping >/dev/null 2>&1 && break
          sleep 0.05
        done
      fi

      monitors_json=$("$hyprctl" monitors -j)
      read -r widget_width widget_height widget_offset < <("$python" - "$monitors_json" <<'PY'
      import json
      import sys

      def clamp(value, low, high):
          return max(low, min(high, value))

      monitors = json.loads(sys.argv[1] or "[]")
      monitor = next((m for m in monitors if m.get("focused")), monitors[0] if monitors else {})
      width = int(monitor.get("width") or 1920)

      widget_width = clamp(round(width / 7), 260, 560)
      widget_height = clamp(round(widget_width * 1.55), 420, 760)
      offset = clamp(round(widget_width / 5), 50, 90)

      print(widget_width, widget_height, offset)
      PY
      )

      "$eww" --force-wayland reload
      "$eww" --force-wayland open hyprland_keybinds \
        --arg widget_x="''${widget_offset}px" \
        --arg widget_y="''${widget_offset}px" \
        --arg widget_width="''${widget_width}px" \
        --arg widget_height="''${widget_height}px"
    '';
  };

  home.file.".local/bin/hyprland-keybinds-json" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      keybinds="$HOME/.local/share/hyprland/keybinds.tsv"

      if [[ ! -f "$keybinds" ]]; then
        printf '[]\n'
        exit 0
      fi

      ${pkgs.python3}/bin/python3 - "$keybinds" <<'PY'
      import csv
      import json
      import sys

      with open(sys.argv[1], newline="") as file:
          rows = list(csv.DictReader(file, delimiter="\t"))

      print(json.dumps(rows))
      PY
    '';
  };

  home.file.".local/bin/hyprland-keybinds-text" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      keybinds="$HOME/.local/share/hyprland/keybinds.tsv"

      if [[ ! -f "$keybinds" ]]; then
        printf 'Missing keybind file: %s\n' "$keybinds"
        exit 0
      fi

      awk -F '\t' 'NR > 1 { printf "%-22s %s\n", $1, $2 }' "$keybinds"
    '';
  };

  home.file.".local/bin/hyprland-keybinds-markup" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      keybinds="$HOME/.local/share/hyprland/keybinds.tsv"

      if [[ ! -f "$keybinds" ]]; then
        printf 'Missing keybind file: %s\n' "$keybinds"
        exit 0
      fi

      ${pkgs.python3}/bin/python3 - "$keybinds" <<'PY'
      import csv
      import html
      import sys

      rows = []
      with open(sys.argv[1], newline="") as file:
          rows = list(csv.DictReader(file, delimiter="\t"))

      for index, row in enumerate(rows):
          if index in (8, 16):
              print('<span foreground="#bbc2cf">----------------------------</span>')

          keys = html.escape(row["keys"][:15].ljust(15))
          action = html.escape(row["action"][:24])
          print(f'<span foreground="#bbc2cf">{keys}</span> <span foreground="#51afef">{action}</span>')
      PY
    '';
  };

  home.file.".local/bin/hyprland-keybinds-rofi" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      keybinds="$HOME/.local/share/hyprland/keybinds.tsv"

      if [[ ! -f "$keybinds" ]]; then
        rofi -e "Missing keybind file: $keybinds"
        exit 1
      fi

      awk -F '\t' 'NR > 1 { printf "%-28s %s\n", $1, $2 }' "$keybinds" \
        | rofi -dmenu -i -p "Keybinds" -no-custom \
            -theme sidebar \
            -theme-str 'window { width: 760px; }' \
            -theme-str 'listview { lines: 18; }'
    '';
  };
}

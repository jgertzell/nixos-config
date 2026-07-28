[
  { keys = "SUPER + F1"; shortKeys = "S+F1"; action = "Open searchable keybind menu"; shortAction = "rofi menu"; command = "/home/jgertzell/.local/bin/hyprland-keybinds"; }
  { keys = "SUPER + F8"; shortKeys = "S+F8"; action = "Rebuild and switch NixOS config"; shortAction = "nixos switch"; command = "kitty --title nixos-switch nu -ic 'nixos-switch; input \"Press Enter to close...\"'"; }
  { keys = "SUPER + D"; shortKeys = "S+D"; action = "Open desktop app launcher"; shortAction = "app launcher"; command = "rofi -show drun -theme sidebar"; }
  { keys = "SUPER + Return"; shortKeys = "S+RET"; action = "Open terminal"; shortAction = "terminal"; command = "kitty"; }
  { keys = "SUPER + Shift + Return"; shortKeys = "S+Sh+RET"; action = "Open floating 90x20 terminal"; shortAction = "float term"; command = "kitty --class floating-terminal --title floating-terminal --override initial_window_width=90c --override initial_window_height=20c"; }
  { keys = "SUPER + Q"; shortKeys = "S+Q"; action = "Close active window"; shortAction = "close window"; command = "hyprctl dispatch killactive"; }
  { keys = "SUPER + M"; shortKeys = "S+M"; action = "Open shutdown menu or exit Hyprland"; shortAction = "shutdown/exit"; command = "hyprshutdown or hyprctl dispatch exit"; }
  { keys = "SUPER + E"; shortKeys = "S+E"; action = "Enter execute mode"; shortAction = "execute"; command = ''hl.dsp.submap("execute")''; }
  { keys = "SUPER + E, E"; shortKeys = "S+E,E"; action = "Open file manager"; shortAction = "file manager"; command = "thunar"; }
  { keys = "SUPER + E, T"; shortKeys = "S+E,T"; action = "Open terminal"; shortAction = "terminal"; command = "kitty"; }
  { keys = "SUPER + E, P"; shortKeys = "S+E,P"; action = "Open PowerShell terminal"; shortAction = "pwsh term"; command = "kitty pwsh"; }
  { keys = "SUPER + E, F"; shortKeys = "S+E,F"; action = "Open Firefox"; shortAction = "firefox"; command = "firefox"; }
  { keys = "SUPER + E, D"; shortKeys = "S+E,D"; action = "Open desktop app launcher"; shortAction = "app launcher"; command = "rofi -show drun -theme sidebar"; }
  { keys = "SUPER + Shift + Space"; shortKeys = "S+Sh+SPC"; action = "Toggle floating window and resize to 480x270"; shortAction = "float 480x270"; command = ''hl.dsp.window.float({ action = "toggle" }); hl.dsp.window.resize({ x = 480, y = 270 }); hl.dsp.window.center()''; }
  { keys = "SUPER + R"; shortKeys = "S+R"; action = "Open launcher"; shortAction = "launcher"; command = "hyprlauncher"; }
  { keys = "SUPER + P"; shortKeys = "S+P"; action = "Reapply display profile"; shortAction = "display profile"; command = "systemctl --user restart kanshi.service"; }
  { keys = "SUPER + Shift + P"; shortKeys = "S+Sh+P"; action = "Toggle pseudo tiling"; shortAction = "pseudo tile"; command = "hyprctl dispatch pseudo"; }
  { separator = true; }
  { keys = "SUPER + J"; shortKeys = "S+J"; action = "Toggle split direction"; shortAction = "split toggle"; command = "hyprctl dispatch togglesplit"; }
  { keys = "SUPER + Arrow keys"; shortKeys = "S+arrows"; action = "Move focus"; shortAction = "move focus"; command = "hyprctl dispatch movefocus"; }
  { keys = "SUPER + 1-0"; shortKeys = "S+1-0"; action = "Switch workspace 1-10"; shortAction = "workspace"; command = "hyprctl dispatch workspace"; }
  { keys = "SUPER + Shift + 1-0"; shortKeys = "S+Shift+1-0"; action = "Move active window to workspace 1-10"; shortAction = "move window"; command = "hyprctl dispatch movetoworkspace"; }
  { keys = "SUPER + S"; shortKeys = "S+S"; action = "Toggle special workspace"; shortAction = "scratchpad"; command = "hyprctl dispatch togglespecialworkspace magic"; }
  { keys = "SUPER + Shift + A"; shortKeys = "S+Shift+A"; action = "Move active window to special workspace"; shortAction = "send scratch"; command = "hyprctl dispatch movetoworkspacesilent special:magic"; }
  { keys = "SUPER + Shift + S"; shortKeys = "S+Shift+S"; action = "Select area screenshot and edit"; shortAction = "screenshot"; command = ''grim -g "$(slurp)" - | swappy -f -''; }
  { keys = "SUPER + Mouse wheel"; shortKeys = "S+wheel"; action = "Cycle workspaces"; shortAction = "cycle ws"; command = "hyprctl dispatch workspace e+1/e-1"; }
  { keys = "SUPER + Left mouse drag"; shortKeys = "S+LMB"; action = "Move window"; shortAction = "move win"; command = "hyprctl dispatch movewindow"; }
  { keys = "SUPER + Right mouse drag"; shortKeys = "S+RMB"; action = "Resize window"; shortAction = "resize win"; command = "hyprctl dispatch resizewindow"; }
  { separator = true; }
  { keys = "Volume up"; shortKeys = "Vol +/-"; action = "Raise volume"; shortAction = "volume"; command = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"; }
  { keys = "Volume down"; shortKeys = "Vol down"; action = "Lower volume"; shortAction = "volume"; command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"; }
  { keys = "Mute"; shortKeys = "Mute"; action = "Toggle speaker mute"; shortAction = "mute"; command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
  { keys = "Mic mute"; shortKeys = "Mic mute"; action = "Toggle microphone mute"; shortAction = "mic mute"; command = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
  { keys = "Brightness up"; shortKeys = "Bright +/-"; action = "Raise screen brightness"; shortAction = "brightness"; command = "brightnessctl -e4 -n2 set 5%+"; }
  { keys = "Brightness down"; shortKeys = "Bright down"; action = "Lower screen brightness"; shortAction = "brightness"; command = "brightnessctl -e4 -n2 set 5%-"; }
  { keys = "Media next"; shortKeys = "Media next"; action = "Next media track"; shortAction = "playback"; command = "playerctl next"; }
  { keys = "Media play/pause"; shortKeys = "Media play"; action = "Toggle media playback"; shortAction = "playback"; command = "playerctl play-pause"; }
  { keys = "Media previous"; shortKeys = "Media prev"; action = "Previous media track"; shortAction = "playback"; command = "playerctl previous"; }
]

#!/usr/bin/env bash

# Toggle hyprpicker: kill if running, otherwise pick a color and copy it to clipboard
if pgrep -x "hyprpicker" >/dev/null; then
  pkill -x "hyprpicker"
else
  color=$(hyprpicker -a -f hex) # -a = autocopy to wl-clipboard, -f = format
  [ -n "$color" ] && notify-send "Color picked" "$color"
fi

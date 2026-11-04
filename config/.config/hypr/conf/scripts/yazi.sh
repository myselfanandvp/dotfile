#!/usr/bin/env bash

# Check if yazi is currently running
if pgrep -x "yazi" >/dev/null; then
  pkill -x "yazi"
else
  kitty --title="yazi-float" -e yazi &

fi

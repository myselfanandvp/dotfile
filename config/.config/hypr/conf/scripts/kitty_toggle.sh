#!/usr/bin/env bash

# Check if kitty with class float-term is running
if pgrep -f "float-term" >/dev/null; then
  pkill -f "float-term"
else
  kitty --title="float-term" &
fi

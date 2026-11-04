#!/usr/bin/env bash

# Check if btop is currently running
if pgrep -x "wooz" >/dev/null; then
  pkill -x "wooz"
else
  wooz --zoom-in 50% --mouse-track &
fi

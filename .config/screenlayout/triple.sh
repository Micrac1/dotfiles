#!/bin/sh
xrandr \
  --output VGA1 --mode 1280x1024 --rate 75.02 --pos 0x56 \
  --output HDMI-0 --primary --mode 1920x1080 --rate 75.00 --pos 1280x0 \
  --output DP-1 --auto --pos 3200x0

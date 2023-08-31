#!/bin/bash
#pactl set-source-mute @DEFAULT_SOURCE@ toggle
SOURCE=alsa_input.pci-0000_00_1b.0.analog-stereo
if [ "$1" = "" ]; then
  pactl set-source-mute "$SOURCE" toggle
fi
STATUS=$(pactl list sources | grep "$SOURCE" -m 1 -A6 | grep 'Mute: ' | cut -d' ' -f2)

if [ "$STATUS" = 'yes' ]; then
	#notify-send 'Microphone Muted'
	xset led named "Scroll Lock"
else
	#notify-send 'Microphone Unmuted'
	xset -led named "Scroll Lock"
fi

if [ "$1" = "" ]; then
  paplay /usr/share/sounds/freedesktop/stereo/bell.oga
fi

#!/bin/bash

if [ "$1" = "" ]; then
  pactl set-source-mute @DEFAULT_SOURCE@ toggle
fi
STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@ | cut -d ' ' -f2)

if [ "$STATUS" = 'yes' ]; then
	xset led named "Scroll Lock"
else
	xset -led named "Scroll Lock"
fi

if [ "$1" = "" ]; then
  paplay /usr/share/sounds/freedesktop/stereo/bell.oga
fi

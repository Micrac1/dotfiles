#!/bin/bash

notify-send "Ding!" "$1"
echo -e -n '\007'
paplay "/usr/share/sounds/freedesktop/stereo/complete.oga" > /dev/null

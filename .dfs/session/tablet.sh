#!/bin/bash
# xinput list
device_name='GAOMON Gaomon Tablet stylus'
id=$(xinput list --id-only "${device_name}")

echo "Applied settings for ${device_name} (id ${id})"

#set position
#xsetwacom set "${id}" MapToOutput 1920x1080+1280+0
xsetwacom set "${id}" MapToOutput `xrandr --listactivemonitors | grep \* | cut -d' ' -f4 | sed 's:/.*x:x:' | sed 's:/[0-9]*+:+:'`

#set area
xsetwacom set "${id}" Area 0 873 33020 19447
# Require touching for pen buttons
xsetwacom set 19 TabletPCButton on

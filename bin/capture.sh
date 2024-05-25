#!/bin/sh
set -e
OUTPATH="/media/blue/Videos/clips/$(date +'%Y-%m-%d_%H-%M-%s.mp4')"
read -r X Y W H < <(slop -nok -f "%x %y %w %h") || true

sleep 1s

# -y for force overwrite
ffmpeg ${1:+ -t ${1}} -video_size "${W}x${H}" -framerate 30 -f x11grab \
  -i ":0.0+${X},${Y}" -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -pix_fmt yuv422p "${OUTPATH}"

ln -sf "${OUTPATH}" /tmp/capture.mp4

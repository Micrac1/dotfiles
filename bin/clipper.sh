#!/bin/sh

stop_ffmpeg(){
  echo asd
  echo asd
  echo asd
  echo asd
  echo asd
  echo asd
  echo asd
  #echo q > "${FFMPEG_STDIN}"
}

#DURATION=40
FRAMERATE=50
GIF_OUT_FOLDER="/media/blue/Videos/clips"
GIF_OUT_FILE_BASE="${GIF_OUT_FOLDER}/clip_$(date +'%Y-%m-%d_%H%M')"

# ------------------------------------------------------------------------------

# Output directory and file
mkdir -p "${GIF_OUT_FOLDER}"; test -d "${GIF_OUT_FOLDER}" \
  || echo "[CLIPPER] Error: ${GIF_OUT_FOLDER} could not be created!" >&2

if [ -e "${GIF_OUT_FILE_BASE}.gif" ]; then
  i="0"
  while [ -e "${GIF_OUT_FILE}-${i}.gif" ]; do
    i="$((i++))"
  done
  GIF_OUT_FILE="${GIF_OUT_FILE_BASE}-${i}.gif"
else
  GIF_OUT_FILE="${GIF_OUT_FILE_BASE}.gif"
fi
touch "${GIF_OUT_FILE}"

# Select region
read -r X Y W H C < <(slop -f "%x %y %w %h %c")

# TMP recording
TMP_VID=$(mktemp /tmp/clipper_tmpXXX.mp4)

#killall --user ${USER} --ignore-case  --signal INT  ffmpeg \
ffmpeg -s "${W}x${H}" -y -f x11grab -i ":0.0+${X},${Y}" -vcodec huffyuv -r "${FRAMERATE}" "${TMP_VID}"

convert "${TMP_VID}" -layers removeDups -layers Optimize -delay 13 -loop 0 \
  "${GIF_OUT_FILE}" \
&& rm -I "${TMP_VID}" \
&& gifsicle --verbose --batch --interlace ${GIF_OUT_FILE} --optimize=05 --colors=128 # --output  out.gif

####################################
echo DONE
exit
# Collect the YAD options
cmd=(yad 
    --width 5
    --height 5
    --on-top
    --skip-taskbar
    --borders=0
    #--undecorated  (so you have something to grab it if you want to move it)
    --columns 1
    --no-focus
    #--mouse (it gets a bit inside the recording window)
    --geometry=5x5+$(($X+$W+10))+$(($Y+$H+10))
    #--no-buttons  (avoids having buttons we don't need)
    # This is a trick to have the buttons vertical
    --form  
    --title="Screencast to GIF"
    --field='Start recording!stop!Start recording (maximum defined duration)':fbtn 'bash -c "start_recording_screen_section"'
    --field='Stop recording!gtk-quit!Stop recording and create gif file in output folder':fbtn 'bash -c "stop_recording_and_create_gif & kill -SIGUSR1 $YAD_PID"'
    --field='Pause!gtk-pause!':fbtn 'bash -c "FPause"'
    --field='Continue!gtk-continue!':fbtn 'bash -c "FContinue"'
    --button='Quit!gtk-ok':'bash -c "kill -SIGUSR1 $YAD_PID"'
)
# Run yad
"${cmd[@]}"

# Cleanup before leaving
unset TMP_AVI DURATION GIF_OUT_FOLDER GIF_OUT_FILE X Y W H C
unset stop_recording_and_create_gif
unset start_recording_screen_section
unset FContinue FPause

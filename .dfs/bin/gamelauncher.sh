#!/bin/bash
LIST=(
  "Minecraft" '~/bin/wp.sh -n mc ; gamemoderun minecraft-launcher'
  "Brawlhalla" '~/bin/wp.sh -n bh ; steam -applaunch 291550'
  "Dota 2" '~/bin/wp.sh -n dota ; steam -applaunch 570'
  "CS:GO" '~/bin/wp.sh -n csgo ; steam -applaunch 730'
  "ATLauncher" 'gamemoderun atlauncher'
  "Xonotic" 'gamemoderun xonotic-sdl'
  "Super Tux Kart" 'gamemoderun supertuxkart'

  "Test" 'notify-send $HOSTNAME ; notify-send test2 ; sleep 20s'
)

get_game(){
  # check if we have yad installed, fall back to zenity
  DIALOG_CMD=""
  if [ -x `command -v yad` ]; then
    DIALOG_CMD="yad"
  elif [ -x `command -v zenity` ]; then
    DIALOG_CMD="zenity"
  else
    printf "Error: yad and zenity are unavailable. Exiting...\n"
  fi
  echo $("${DIALOG_CMD}" --list --separator='' --hide-header \
    --hide-column=2 --print-column=2 --search-column=1 \
    --height=480 \
    --title="Launch Game" --text "Launch Game" \
    --column="Game" --column="command"  \
    -- "${LIST[@]}")
}

GAME="$(get_game)"
eval "${GAME}" &

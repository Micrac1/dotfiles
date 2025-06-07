#!/bin/sh

MODULE_NAME="pulsemute"
: "${INTERVAL=60}"

. "$(dirname "${0}")/base.sh"
if [ -z "${BASE_SH_SUCCESS}" ]; then
  echo "Failed to initalize base.sh"; exit 101
fi

: "${BUTTON_MUTED=M}"
: "${BUTTON_UNMUTED=N}"
: "${SOURCE_NAME=@DEFAULT_SOURCE@}"

print_module(){
  STATUS=$(pactl get-source-mute "${SOURCE_NAME}" | cut -d ' ' -f2)

  if [ "${STATUS}" = 'yes' ]; then
    echo "${BUTTON_MUTED}"
  else
    echo "${BUTTON_UNMUTED}"
  fi

  if [ "${STATUS}" = 'yes' ]; then
    xset led named "Scroll Lock"
  else
    xset -led named "Scroll Lock"
  fi
}

poke_function(){
  pactl subscribe | stdbuf -o0 grep "Event 'change' on source" |\
  while read -r OWO; do
    print_module
  done
}

click_left(){
  pactl set-source-mute "${SOURCE_NAME}" toggle
}

poke_function &
start_loop

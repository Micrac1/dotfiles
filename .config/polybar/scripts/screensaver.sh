#!/bin/sh

MODULE_NAME="screensaver"
. "$(dirname "${0}")/base.sh"
if [ -z "${BASE_SH_SUCCESS}" ]; then
  echo "Failed to initalize base.sh"; exit 101
fi

# ============================================================================
#PREVENT_IDLE="yes"
# Countdown to timeout if unset, countdown to timeout + cycle when set
# COUNTDOWN_TO_CYCLE="true"
: "${LOCK_STRING=LCK}"
# ============================================================================
# TODO:
# env for reverse (count up, not down)
# env for enabling counter in minutes, not seconds

# Toggle between timeout and always on
click_left(){
  update_state

  if [ "${_TIMEOUT}" = '0' ]; then
    _RESTORE_TIMEOUT="$(xrdb -get dfs.screenTimeout)"
    : "${_RESTORE_TIMEOUT:=0}"
    xset s "${_RESTORE_TIMEOUT}" >/dev/null 2>&1
  else
    xset s 0 >/dev/null 2>&1
  fi
}

print_module(){
  update_state
  print_state
}

update_state(){
  _IDLE_TIME=$(xprintidle)
  if [ -n "${_IDLE_TIME}" ]; then
    _IDLE_TIME=$(( _IDLE_TIME / 1000 ))
  fi

  _TIMEOUT="$(echo "$(xset q)" | grep -o -P 'timeout: *\K[0-9]+')"
}

print_state(){
  if [ "${_TIMEOUT}" = '0' ]; then
    echo "${LOCK_STRING}"
  elif [ "${_TIMEOUT}" -gt "${_IDLE_TIME}" ] 2>/dev/null; then
    printf "%3s\n" "$(( "${_TIMEOUT}" - "${_IDLE_TIME}" ))"
  else
    echo "ERR"
  fi
}

x_prevent_idle(){ xdotool key VoidSymbol; }

start_loop

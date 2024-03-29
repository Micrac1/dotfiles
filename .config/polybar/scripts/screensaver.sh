#!/bin/sh
. "$(dirname "${0}")/base.sh"
if [ -z "${BASE_SH_SUCCESS}" ]; then
  echo "Failed to initalize base.sh"; exit 101
fi

# ============================================================================
#PREVENT_IDLE="yes"
# Countdown to timeout if unset, countdown to timeout + cycle when set
COUNTDOWN_TO_CYCLE="yes"
# ============================================================================

click_left(){
  update_state
  if [ "${_TIMEOUT}" = '0' ]; then
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
    _IDLE_TIME=$(( ${_IDLE_TIME} / 1000 ))
  fi

  _XSET_OUT=$(xset q)
  _TIMEOUT="$(echo "${_XSET_OUT}" | grep -o -P 'timeout: *\K[0-9]+')"
  _CYCLE="$(echo "${_XSET_OUT}" | grep -o -P 'cycle: *\K[0-9]+')"
}

print_state(){
  if [ "${_TIMEOUT}" = '0' ]; then
    echo "W" # TODO make env
  elif [ "${_TIMEOUT}" -gt "${_IDLE_TIME}" ] 2>/dev/null; then
    # TODO handle other cases
    echo "$(( "${_TIMEOUT}" - "${_IDLE_TIME}" ))"
  fi
}

x_prevent_idle(){ xdotool key VoidSymbol; }

_XSET_OUT=$(xset q)
_RESTORE_TIMEOUT="$(echo "${_XSET_OUT}" | grep -o -P 'timeout: *\K[0-9]+')"
_RESTORE_CYCLE="$(echo "${_XSET_OUT}" | grep -o -P 'cycle: *\K[0-9]+')"

start_loop

#!/bin/sh
# shellcheck disable=SC2086,SC2016,SC2034

# Copy this to a new file to create a new module:
# ============================================================================
# . "$(dirname "${0}")/base.sh"
# if [ -z "${BASE_SH_SUCCESS}" ]; then
#   echo "Failed to initalize base.sh"; exit 101
# fi
# ============================================================================


# Copy this to create a new instance
# ============================================================================
# [module/cool_script]
# type = custom/script
# exec = "${XDG_CONFIG_HOME:-${HOME}/.config}/polybar/scripts/my_module.sh"
# tail = true
# click-left = echo 'click-left' > /tmp/polybar_module_cool_script_%pid%
# click-right = echo 'click-right' > /tmp/polybar_module_cool_script_%pid%
#
# env-MODULE_NAME = cool_script
# ============================================================================


# = MODULE CONFIGURATION =====================================================

# Environmental variables: (can be set per module or per script)

# Interval between updates in seconds. Whole integer.
: "${INTERVAL=30}"

# Name of the module
: "${MODULE_NAME=default}"

# Path to a pipe THAT WILL BE CREATED to communicate with
# the module. The path will have the script pid appended.
: "${PIPE_DIR=/tmp}"

# Functions
print_module(){ :; } # overwrite to actually print something
cleanup(){ :; } # called when the script is exiting

# Interaction
click_left(){ :; }
click_middle(){ :; }
click_right(){ :; }
scroll_up(){ :; }
scroll_down(){ :; }
double_click_left(){ :; }
double_click_middle(){ :; }
double_click_right(){ :; }
event_handler(){ :; } # any other piped command gets handled by this
# ============================================================================

export PIPE="${PIPE_DIR}/polybar_module_${MODULE_NAME}_${$}"

export SEP='%{-u} %{+u}'

export _PID="${$}"

_cleanup(){
  # TODO chcek if exists
  rm "${PIPE}" 2>/dev/null
  cleanup && exit 0 || exit 10
}

_timer_loop(){
  if ! sleep "${INTERVAL}"; then
    echo "INVALID INTERVAL: ${INTERVAL}"
  fi
  refresh
}

refresh(){
  kill -USR1 "${_PID}"
}

start_loop(){

  mkfifo "${PIPE}"
  if [ ! -r "${PIPE}" ] || [ ! -p "${PIPE}" ]; then
    exit 9
  fi
  exec <>"${PIPE}"
  trap '_cleanup' INT TERM
  # receiving any interrupt gets us out of read -r, we don't need to do anything special
  trap ':' USR1

  _DO_LOOP="yes"
  while [ "${_DO_LOOP}" = "yes" ]; do
    # periodically check if the pipe is alive
    if [ ! -r "${PIPE}" ] || [ ! -p "${PIPE}" ]; then
      echo "PIPE DELETED ${PIPE}"
      sleep 5s
      exit 90 # polybar will restart us ;)
    fi
    print_module

    # restart the timer after manual interaction
    kill -- "${_TIMER_PID}" 2>/dev/null
    if [ "${INTERVAL}" -gt 0 ]; then
      _timer_loop &
      _TIMER_PID="${!}"
    fi

    line=''
    read -r line
    case "${line}" in
      "refresh") : ;;
      "click-left") click_left ;;
      "click-middle") click_middle ;;
      "click-right") click_right ;;
      "scroll-up") scroll_up ;;
      "scroll-down") scroll_down ;;
      "double-click-left") double_click_left ;;
      "double-click-middle") double_click_middle ;;
      "double-click-right") double_click_right ;;
      "exit") _DO_LOOP="" ;;
      *) event_handler "${line}" ;;
    esac
  done
  _cleanup
}

export BASE_SH_SUCCESS="success"

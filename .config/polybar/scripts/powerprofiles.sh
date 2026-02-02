#!/bin/sh

MODULE_NAME="powerprofiles"
. "$(dirname "${0}")/base.sh"
if [ -z "${BASE_SH_SUCCESS}" ]; then
  echo "Failed to initalize base.sh"; exit 101
fi

# ============================================================================
# Environmental variables
: "${LABEL_PROGRESS=*}"
: "${LABEL_PERFORMANCE=P}"
: "${LABEL_POWERSAVE=S}"
: "${LABEL_SCHEDUTIL=s}"
: "${LABEL_BALANCED=b}"
: "${LABEL_UNKNOWN=?}"
# ============================================================================


# ============================================================================
_PROFILE=''

update_state(){
  _PROFILE="$(powerprofilesctl get)"
}

print_state(){
  case "${_PROFILE}" in
    "performance" )
      echo "${LABEL_PERFORMANCE}"
      ;;
    "power-saver")
      echo "${LABEL_POWERSAVE}"
      ;;
    "balanced")
      echo "${LABEL_BALANCED}"
      ;;
    "schedutil")
      echo "${LABEL_SCHEDUTIL}"
      ;;
    *)
      echo "${LABEL_UNKNOWN}"
      ;;
  esac
}

click_left(){
  echo "${LABEL_PROGRESS}"
  update_state
  if [ "${_PROFILE}" = "power-saver" ]; then
    powerprofilesctl set "balanced" > /dev/null 2>&1
  else
    powerprofilesctl set "power-saver" > /dev/null 2>&1
  fi
}

click_right(){
  update_state
  echo "${LABEL_PROGRESS}"
  powerprofilesctl set "performance"
}

print_module(){
  update_state
  print_state
}

start_loop

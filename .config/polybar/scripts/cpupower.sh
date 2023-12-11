#!/bin/sh
. "$(dirname "${0}")/base.sh"
if [ -z "${BASE_SH_SUCCESS}" ]; then
  echo "Failed to initalize base.sh"; exit 101
fi

# ============================================================================
# Environmental variables
LABEL_PROGRESS="${LABEL_PROGRESS:-*}"
LABEL_PERFORMANCE="${LABEL_PERFORMANCE:-P}"
LABEL_POWERSAVE="${LABEL_POWERSAVE:-S}"
LABEL_UNKNOWN="${LABEL_UNKNOWN:-?}"
# ============================================================================


# ============================================================================
_GOVERNOR=''

update_state(){
  _GOVERNOR="$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor)"
}

print_state(){
  if [ "${_GOVERNOR}" = "performance" ]; then
    echo "${LABEL_PERFORMANCE}"
  elif [ "${_GOVERNOR}" = "powersave" ]; then
    echo "${LABEL_POWERSAVE}"
  else
    echo "${LABEL_UNKNOWN}"
  fi 
}

click_left(){
  update_state
  if [ "${_GOVERNOR}" = "performance" ]; then
    echo "${LABEL_PROGRESS}"
    cpupower-gui profile "Powersave" > /dev/null 2>&1
  elif [ "${_GOVERNOR}" = "powersave" ]; then
    echo "${LABEL_PROGRESS}"
    cpupower-gui profile "Performance" > /dev/null 2>&1
  fi 
}

print_module(){
  update_state
  print_state
}

start_loop

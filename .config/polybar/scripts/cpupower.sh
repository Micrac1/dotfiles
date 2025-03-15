#!/bin/sh
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
: "${LABEL_UNKNOWN=?}"
# ============================================================================


# ============================================================================
_GOVERNOR=''

update_state(){
  _GOVERNOR="$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor)"
}

print_state(){
  case "${_GOVERNOR}" in
    "performance" )
      echo "${LABEL_PERFORMANCE}"
      ;;
    "powersave")
      echo "${LABEL_POWERSAVE}"
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
  update_state
  if [ "${_GOVERNOR}" = "performance" ]; then
    echo "${LABEL_PROGRESS}"
    cpupower-gui profile "Balanced" > /dev/null 2>&1
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

#!/bin/sh

MODULE_NAME="tuned"
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
  # _GOVERNOR="$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor)"
  _PROFILE="$(tuned-adm active)"
  _PROFILE="${_PROFILE##*: }"
}

print_state(){
  case "${_PROFILE}" in
    "throughput-performance" )
      echo "${LABEL_PERFORMANCE}"
      ;;
    "powersave")
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
  if [ "${_PROFILE}" = "powersave" ]; then
    tuned-adm profile "balanced" > /dev/null 2>&1
  else
    tuned-adm profile "powersave" > /dev/null 2>&1
  fi
}

click_right(){
  update_state
  echo "${LABEL_PROGRESS}"
  tuned-adm profile "throughput-performance"
}

print_module(){
  update_state
  print_state
}

start_loop

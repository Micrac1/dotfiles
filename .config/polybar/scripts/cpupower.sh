#!/bin/sh
GOVERNOR=''
spid=0

killspid(){
  if [ "${spid}" -ne 0 ]; then
    kill "${spid}" > /dev/null 2>&1
  fi
}

update_state(){
  GOVERNOR="$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor)"
}

print_state(){
  if [ "${GOVERNOR}" = "performance" ]; then
    echo "${LABEL_PERFORMANCE:-P}"
  elif [ "${GOVERNOR}" = "powersave" ]; then
    echo "${LABEL_POWERSAVE:-S}"
  else
    echo "${LABEL_UNKNOWN:-?}"
  fi 
}

click_left(){
  update_state
  if [ "${GOVERNOR}" = "performance" ]; then
    echo "${LABEL_PROGRESS:-*}"
    cpupower-gui profile "Powersave" > /dev/null 2>&1
  elif [ "${GOVERNOR}" = "powersave" ]; then
    echo "${LABEL_PROGRESS:-*}"
    cpupower-gui profile "Performance" > /dev/null 2>&1
  fi 
  killspid
}

trap "click_left" USR1
trap "click_right" USR2

while true; do
  update_state
  print_state
  sleep "${INTERVAL:-30s}" &
  spid=$!
  wait
done

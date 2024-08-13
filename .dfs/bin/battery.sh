#!/bin/sh
_DEVICE_PATH="/sys/class/power_supply/BAT0"

for _DEVICE_PATH in "/sys/class/power_supply/BAT"* ; do
  _CYCLE_COUNT="$(cat "${_DEVICE_PATH}/cycle_count")"
  _STATUS="$(cat "${_DEVICE_PATH}/status")"

  _CAPACITY_FULL="$(echo "scale=2; $(cat "${_DEVICE_PATH}/energy_full") / 1000000" | bc)"
  _CAPACITY_FULL_DESIGN="$(echo "scale=2; $(cat "${_DEVICE_PATH}/energy_full_design") / 1000000" | bc)"
  _CAPACITY_PERCENT="$(echo "scale=2; ${_CAPACITY_FULL} * 100 / ${_CAPACITY_FULL_DESIGN}" | bc)"

  _LEVEL="$(echo "scale=2; $(cat "${_DEVICE_PATH}/energy_now") / 1000000" | bc)"
  _LEVEL_PERCENT="$(echo "scale=2; ${_LEVEL} * 100 / ${_CAPACITY_FULL}" | bc)"

  _W_USAGE="$(echo "scale=2; $(cat "${_DEVICE_PATH}/power_now") / 1000000" | bc)"
  _REMAINING="$(echo "scale=2; ${_LEVEL} / ${_W_USAGE}" | bc)"

  # Print
  echo "Device:      ${_DEVICE_PATH}"
  echo "Cycle count: ${_CYCLE_COUNT}"
  echo "Capacity:    ${_CAPACITY_PERCENT}% (${_CAPACITY_FULL}Wh / ${_CAPACITY_FULL_DESIGN}Wh)"
  echo "Status:      ${_STATUS}"
  echo "Level:       ${_LEVEL_PERCENT}% (${_LEVEL}Wh / ${_CAPACITY_FULL}Wh)"
  echo "Usage:       ${_W_USAGE}W (${_REMAINING}h left)"
done


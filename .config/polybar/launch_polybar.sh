#!/bin/bash
#killall polybar 2>/dev/null
if xdotool --version; then
  for bar in $(xdotool search --class '^polybar$' getwindowpid %@); do
    polybar-msg -p "${bar}" cmd quit
  done
fi

FLAGS="--reload"
if [ "$1" != "-d" ]; then
  FLAGS+=" --quiet"
fi

# Check what computer are we on
case "${HOSTNAME}" in 
  "ende"|"clamp")
    CONFIG="_${HOSTNAME}"
    ;;
  *)
    CONFIG=""
    ;;
esac

# check if we have xrandr
if ! xrandr --version > /dev/null; then
  echo "[POLYBAR] Error: xrandr not found! Running a single polybar instance..."
  polybar ${FLAGS} "primary${CONFIG}" &
  exit
fi

PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)

# Primary display exists
if test -n "${PRIMARY}"; then
  # Launch secondary on every NON-primaray monitor
  for m in $(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1); do
    # launch secondary
    POLYBAR_MONITOR="${m}" polybar ${FLAGS} "secondary${CONFIG}" &
  done
  # launch primary on primary monitor
  POLYBAR_MONITOR="${PRIMARY}" polybar ${FLAGS} "primary${CONFIG}" &
else
  # Launch primary on every connected monitor
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    POLYBAR_MONITOR="${m}" polybar ${FLAGS} "primary${CONFIG}" &
  done
fi

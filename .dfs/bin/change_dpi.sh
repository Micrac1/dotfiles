#!/bin/sh
XSETTINGS_FILE="/tmp/xsettings"
_DPI="$1"
if [ -z "${_DPI}" ]; then
  echo "Error: DPI argument required. Exiting."
  exit 1
fi

if [ "${_DPI}" -lt 0 ]; then
  echo "Error: Invalid DPI. Exiting."
  exit 2
fi
_CURSOR_SIZE="$(( 24 * "${_DPI}" / 96 ))"
echo $_CURSOR_SIZE


# Reset previous settings
echo "" > "${XSETTINGS_FILE}"


# DPI
echo "Xft.dpi: ${_DPI}" | xrdb -override
echo "Xft/DPI $(( "${_DPI}" * 1024 ))" >> "${XSETTINGS_FILE}"

# Cursor size
echo "Xcursor.size: ${_CURSOR_SIZE}" | xrdb -override
echo "Gtk/CursorThemeSize "${_CURSOR_SIZE}"" >> "${XSETTINGS_FILE}"

xsettingsd -c "${XSETTINGS_FILE}" >/dev/null 2>&1 &
i3-msg restart
"${HOME}/.config/polybar/launch_polybar.sh"

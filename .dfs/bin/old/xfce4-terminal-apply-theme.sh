#!/bin/bash

# Theme file
if [ -z "$1" ]; then
	THEME="/usr/share/xfce4/terminal/colorschemes/Xresources.theme"
else
	THEME="/usr/share/xfce4/terminal/colorschemes/""$1"".theme"
fi

# config file to edit
CONFIG="${HOME}""/.config/xfce4/terminal/terminalrc"
TMPFILE="/tmp/xrestmp"
cp "${CONFIG}" "${TMPFILE}"

function replace {
	# ex. ColorPalette
	KEY="$1"

	# remove entry from CONFIG
	sed -i  "/^${KEY} *=.*/d" "${TMPFILE}"

	NEWVAL=$(egrep -m 1 "^${KEY} *=" "$THEME" | cut -d'=' -f2)

	# add new value if one if found in the config
	if [ -z ${NEWVAL} ]; then
		echo "${KEY} not found in theme file, skipping!"
		return
	fi

	#echo "${KEY}=${NEWVAL}" >> "${CONFIG}"
	COMMIT="${COMMIT}${KEY}=${NEWVAL}\n"
}

replace ColorSelectionUseDefault
replace ColorBoldUseDefault
replace ColorBoldIsBright
replace ColorCursorUseDefault
replace ColorUseTheme
replace ColorBackgroundVary

replace TabActivityColor

replace ColorCursor
replace ColorCursorForeground
replace ColorBold

replace ColorSelection
replace ColorSelectionBackground

replace ColorBackground
replace ColorForeground
replace ColorPalette

# remove empty lines from the config
echo -e "${COMMIT}" >> "${TMPFILE}"
sed -i "/^$/d" "${TMPFILE}"
mv "${TMPFILE}" "${CONFIG}"
#touch "$CONFIG"

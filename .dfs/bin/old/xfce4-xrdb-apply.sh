#!/bin/bash

CFGFILE=${XDG_CONFIG_HOME:-~/.config}/xfce4/terminal/terminalrc

# Additional setting that will be added to xfce4-terminal
# these are not checked at all and are applied at the end
ADDSETTINGS=(
	'ColorSelectionUseDefault=TRUE'
	'ColorBoldUseDefault=TRUE'
	'ColorBoldIsBright=TRUE'
	'ColorCursorUseDefault=FALSE'
	'ColorUseTheme=FALSE'
	'ColorBackgroundVary=FALSE'
	#TabActivityColor
	#ColorCursorForeground
	#ColorBold
	#ColorSelection
	#ColorSelectionBackground
)

if [ ! -f "${CFGFILE}" ]; then
	echo "Error: ${CFGFILE} does not exist. Exiting..."
	exit 1
fi

TMPFILE=`mktemp`
# check tmp file
if [ ! -f "${TMPFILE}" ]; then
	echo "Error: Could not create temporary file ${TMPFILE}. Exiting..."
	exit 1
fi
cp "${CFGFILE}" "${TMPFILE}"

XRDB=`xrdb -q`

function remove {
	sed -i "/^${1} *=.*/d" "${TMPFILE}"
}

function extract {
	echo `egrep -v "^\!" <<<"${XRDB}" | egrep -m 1 "\*.${1}\:" | awk '{print $NF}'`
}

# xfce4 name, value from Xres
function replace {
	VAL=`extract "${2}"`
	if [ -z "${VAL}" ]; then
		echo "Warn: ${1}, ${2} could not be loaded from XRDB. Skipping..."
		return
	else
		remove "${1}"
		echo "${1}=${VAL}" >> "${TMPFILE}"
	fi
}

# ColorPalette
PALETTE=""
for i in {0..15}; do
	NEWCOLOR=`extract "color${i}"`
	if [ -z "${NEWCOLOR}" ]; then
		echo "Warn: Color ${i} could not be loaded from ${XRESFILE}. Skipping..."
		# Attempt to extract color from the config
		OLDCOLOR=`egrep '^ColorPalette *=' "${CFGFILE}" | cut -d'=' -f2 | cut -d';' -f$((${i} + 1))`
		if [ -z "${OLDCOLOR}" ]; then
			# should never happen
			OLDCOLOR="#00ff00"
		fi
		PALETTE="${PALETTE}"";""${OLDCOLOR}"
	else
		PALETTE="${PALETTE}"";""${NEWCOLOR}"
	fi
done
remove ColorPalette
echo "ColorPalette="`echo "${PALETTE}" | sed 's/^;//g'` >> "${TMPFILE}"


# Read and apply settings from xres
replace ColorForeground        foreground
replace ColorBackground        background
replace ColorCursor            cursorColor
replace ColorCursorForeground  background

# Apply additional settings
for i in "${ADDSETTINGS[@]}"; do
	remove `echo "${i}" | cut -d'=' -f1`
	echo "${i}" >> "${TMPFILE}"
done

# remove empty lines from the config
sed -i "/^$/d" "${TMPFILE}"

# commit tmpfile
if [ -z "${1}" ]; then
	mv "${TMPFILE}" "${CFGFILE}"
	touch "${CFGFILE}"
else
	mv "${TMPFILE}" "${1}"
fi
#cat "${TMPFILE}"

if [ -f "${TMPFILE}" ]; then
	rm "${TMPFILE}"
fi

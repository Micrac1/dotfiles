#!/bin/bash
# Loads Xresources file and reloads selected applications

# Default Xresources file, used when no arguments are given
#XRESFILE=${HOME}/.Xresources
XRESFILE=${HOME}/.config/xresources/Xresources

usage (){
	printf "Usage: xresources.sh [OPTION]... [FILE]\n\n"
	printf "TODO write this shit properly\n\n"
	printf "OPTIONS:\n"
	printf "  -a, --apply                [default] reload default Xresources file and refresh apps (must specify explicitly when using -o)\n"
	printf "  -o, --output [DIRECTORY]   generate config files for external use\n"
	printf "  -n, --no-reload            do not reload xresources file\n"
	printf "  -p, --preset [PRESET]      use preset location (pywall, light, dark,...)\n"
}

# Used for outputting theme files
OUTPUTAPPS=(
	xfce4-terminal
)

# Classic xresources files, NAME and PATH
declare -A PRESETS=(
	['default']="${HOME}/.config/xresources/Xresources"
	['pywall']="${HOME}/.cache/wal/colors.Xresources"
	['matrix']="${HOME}/.config/xresources/matrix.Xresources"
)

# Application to apply xresources to
APPLYAPPS=(
	i3
	xfce4-terminal
	polybar
)

# XFCE4 TERMINAL SETTINGS
XFCEOUTPUTNAME="Xresources.theme"

# Source xfce config file
XFCECFGFILE=${XDG_CONFIG_HOME:-~/.config}/xfce4/terminal/terminalrc

# Additional settings that are set when applying the theme
XFCESETTINGS=(
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

# Extract ${1} value
function extractDB {
	if [ -z "${XRDB}" ]; then
		XRDB=`xrdb -q`
	fi
	echo `grep -E -m 1 "\*.${1}:" <<<"${XRDB}" | awk '{print $NF}'`
}

# xfce4 name, value from Xres, file path
function xfcereplace {
	VAL=`extractDB "${2}"`
	if [ -z "${VAL}" ]; then
		echo "Warn: ${1}, ${2} could not be loaded from XRDB. Skipping..." >&2
		return
	else
		xfceremove "${1}" "${3}"
		echo "${1}=${VAL}" >> "${3}"
	fi
}

# remove ${1} entry from ${2} file (used for replacing old settings with new ones)
# xfceremove "ColorPallete" "$TMPFILE"
function xfceremove {
	sed -i "/^${1} *=.*/d" "${2}"
}

# Modifies argument file with new settings (should be used on a temporary file)
function xfcecolors {
	if [ -z "${1}" ]; then
		echo "WRONG CALL TO CREATEXFCECOLORS! NO ARGUMENT"
	fi

	TMPFILE="${1}"
	# check tmp file
	if [ ! -f "${TMPFILE}" ]; then
		echo "Error: Could not create temporary file ${TMPFILE}. " >&2
		return -1
	fi

	# ColorPalette
	PALETTE=""
	for i in {0..15}; do
		NEWCOLOR=`extractDB "color${i}"`
		if [ -z "${NEWCOLOR}" ]; then
			echo "Warn: Color ${i} could not be loaded from XRDB. Skipping..." >&2
			# Attempt to extract color from the config
			OLDCOLOR=`grep -E '^ColorPalette *=' "${XFCECFGFILE}" | cut -d'=' -f2 | cut -d';' -f$((${i} + 1))`
			if [ -z "${OLDCOLOR}" ]; then
				# should never happen
				OLDCOLOR="#000000"
			fi
			PALETTE="${PALETTE}"";""${OLDCOLOR}"
		else
			PALETTE="${PALETTE}"";""${NEWCOLOR}"
		fi
	done
	xfceremove ColorPalette "${TMPFILE}"
	echo "ColorPalette="`echo "${PALETTE}" | sed 's/^;//g'` >> "${TMPFILE}"

	# Read and apply settings from xres
	xfcereplace ColorForeground        foreground   "${TMPFILE}"
	xfcereplace ColorBackground        background   "${TMPFILE}"
	xfcereplace ColorCursor            cursorColor  "${TMPFILE}"
	xfcereplace ColorCursorForeground  background   "${TMPFILE}"

	# Apply additional settings
	for i in "${XFCESETTINGS[@]}"; do
		xfceremove `echo "${i}" | cut -d'=' -f1` "${TMPFILE}"
		echo "${i}" >> "${TMPFILE}"
	done

	# remove empty lines from the theme file
	sed -i "/^$/d" "${TMPFILE}"
}

# Try to apply theme to all applications in APPS
function apply {
	for app in ${APPLYAPPS[@]}; do
		echo "Applying ${app}..."

		case ${app} in
			i3)
				i3-msg -q reload
			;;

			xfce4-terminal)
				# Create new config and replace old
				TMP=`mktemp`
				if [ ! -f "${TMP}" ]; then
					echo "Error: Could not create temporary file. Skipping..." >2&
					return -1
				fi
				if [ ! -e "${XFCECFGFILE}" ]; then
					echo "Error: ${XFCECFGFILE} does not exist. Skipping..." >2&
					return -1
				fi
				cp "${XFCECFGFILE}" "${TMP}"

				xfcecolors "${TMP}"

				mv "${TMP}" "${XFCECFGFILE}"

				if [ -e "${TMP}" ]; then
					rm "${TMP}"
				fi
			;;

			polybar)
				# reload polybar
				#"$HOME/.config/polybar/launch_polybar.sh"
				touch -m .config/polybar/config
			;;

			*)
				echo "Warn: Application ${1} does not have an apply function. Skipping..." >&2
			;;
		esac
		# fail only when known app fails
		if [ $? -ne 0 ]; then echo "Error: Could not apply xresources to ${app}. Skipping..." >&2; fi
	done
}


function output_app {
	case ${1} in
		xfce4-terminal)
			TMP=`mktemp`
			if [ ! -f "${TMP}" ]; then
				echo "Error: could not create temporary file. Skipping..."
				return -1
			fi
			echo "[Scheme]" >> "${TMP}"
			echo "Name=Xresources" >> "${TMP}"

			xfcecolors "${TMP}"

			# commit tmpfile
			mv "${TMP}" "${OUTPUTDIR}/${XFCEOUTPUTNAME}"

			if [ -f "${TMP}" ]; then
				rm "${TMP}"
			fi
		;;

		*)
			echo "Warn: Unsupported output ${1}. Skipping..." >&2
		;;
	esac
}

function output {
	mkdir -p "${OUTPUTDIR}"
	if [ ! -d "${OUTPUTDIR}" ]; then
		echo "Error: ${OUTPUTDIR} does not exist and could not be created. Exitting..." >&2
		exit -1;
	fi

	for app in ${OUTPUTAPPS[@]}; do
		echo "Outputting ${app} to ${OUTPUTDIR}/..."
		output_app ${app} || {echo "Error: Could not output ${app} config file. Skipping..." >&2}
	done
}


# Load xresources file to the memory
function load_xrdb {
	if [ ! -e "${XRESFILE}" ]; then
		echo "Error: ${XRESFILE} does not exist. Exitting..." >&2
		exit -1
	fi

	echo "Loading ${XRESFILE}..."
	xrdb "${XRESFILE}" || { echo "Error: xrdb failed. Exitting..." >&2; exit -1; }
	# XRESFILE should not be used after this
}

# argument is a preset, returns xresfile path
function preset {
	echo "${PRESETS[${1}]}"
}


# apply, output
NORELOAD=""
APPLY=""
OUTPUT=""
PRESET=""
OUTPUTDIR=""

while (($#)); do
	case ${1} in 
		"-h" | "--help")
			usage
			exit
		;;
		"-p" | "--preset")
			shift
			PRESET="${1}"
			if [ -z "${PRESET}" ]; then
				echo "Error: Preset ${PRESET} not found. Exitting..." >&2
				exit -1
			fi
			shift
		;;

		"-o" | "--output")
			OUTPUT="true"
			# output generated config files (ex. xfce4 theme)
			shift
			OUTPUTDIR="${1}"
			if [ -z "${OUTPUTDIR}" ]; then
				echo "Error: OUTPUTDIR can not be empty. Exitting..." >&2
				exit -1
			fi
			shift
		;;

		"-n" | "--no-reload")
			NORELOAD="true"
			shift
		;;

		"-a" | "--apply")
			APPLY="true"
			shift
		;;

		*)
			# last one counts
			XRESFILE="${1}"
			shift
		;;
	esac
done

# Converting to absolute path might help in some cases, if 
# realpath does not exist on your system just comment this out

if [ ! -z "${PRESET}" ]; then
	if [ ! -z "${NORELOAD}" ]; then
		echo "Warning: Using a preset with noreaload." >&2
	fi
	XRESFILE=`preset "${PRESET}"`
fi

XRESFILE=`realpath ${XRESFILE}`

# Load xrdb
if [ -z "${NORELOAD}" ]; then
	load_xrdb
fi
XRESFILE="" # enforce no XRESFILE usage

if [ "${APPLY}" == "${OUTPUT}" ]; then
	apply
fi

if [ ! -z "${OUTPUT}" ]; then
	output
fi


echo "Done!"

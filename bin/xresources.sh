#!/bin/bash

# Default Xresources file, used when no arguments are given
#XRES_DEFAULT_FILE=${HOME}/.Xresources
_XRES_DEFAULT_FILE="${HOME}/.config/xresources/Xresources"

# Classic xresources files, NAME and PATH
declare -A _XRES_PRESETS=(
  ['default']="${HOME}/.config/xresources/Xresources"
  ['pywall']="${HOME}/.cache/wal/colors.Xresources"
  ['matrix']="${HOME}/.config/xresources/matrix.Xresources"
)

# List of applications that get configured (comment out to disable)
_APPLY_APPS=(
  i3
  xfce4-terminal
  polybar
)

# ========================================================================

# Xfce terminal xml file path
_CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}"

# Additional xfce terminal settings that are set when applying the theme
_XFCE_TERMINAL_SETTINGS=(
  'color-selection-use-default' 'bool' 'true'
  'color-bold-use-default' 'bool' 'true'
  'color-bold-is-bright' 'bool' 'true'
  'color-cursor-use-default' 'bool' 'false'
  'color-use-theme' 'bool' 'false'
  'color-background-vary' 'bool' 'false'
)
#TabActivityColor
#ColorCursorForeground
#ColorBold
#ColorSelection
#ColorSelectionBackground

# Returns ${1} extracted value from $XRDB if not empty, ${2} otherwise
_extractDB() {
  _OUT="$(grep -E -m 1 "\*.${1}:" <<< "${_XRDB}" | awk '{print $NF}')"
  if [ -z "${_OUT}" ]; then
    _OUT="${2}"
    echo "Warning: Color '${1}' could not be loaded from XRDB, using ${2}..." >&2
  fi
  echo "${_OUT}"
}

_apply_xfce() {
  # Create the palette
  _PALETTE=""
  _DELIM=""

  for i in {0..15}; do
    _COLOR="$(_extractDB "color${i}" "#000000")"

    _PALETTE="${_PALETTE}${_DELIM}${_COLOR}"
    _DELIM=';'
  done
  
  # Add the palette to terminal settings
  _SETTINGS=("${_XFCE_TERMINAL_SETTINGS[@]}" 
    'color-palette' 'string' "${_PALETTE}"
    'color-foreground'        'string' "$(_extractDB "foreground"  "#ff0000")"
    'color-background'        'string' "$(_extractDB "background"  "#ff00ff")"
    'color-cursor'            'string' "$(_extractDB "cursorColor" "#ffff00")"
    'color-cursor-foreground' 'string' "$(_extractDB "background"  "#00ff00")"
  )

  for (( i=0; i<${#_SETTINGS[@]}; i+=3 )); do
    _NAME="${_SETTINGS[${i}]}"
    _TYPE="${_SETTINGS[${i} + 1]}"
    _VALUE="${_SETTINGS[${i} + 2]}"
    xfconf-query --create -c xfce4-terminal -p "/${_NAME}" --type "${_TYPE}" -s "${_VALUE}"
  done
}

# Generate the xmlstarlet command
#_XMLSTARLET_COMMAND="xmlstarlet ed -L"
#for (( i=0; i<${#_SETTINGS[@]}; i+=3 )); do
#  _NAME="${_SETTINGS[${i}]}"
#  _TYPE="${_SETTINGS[${i} + 1]}"
#  _VALUE="${_SETTINGS[${i} + 2]}"
#  _XMLSTARLET_COMMAND+="
#    -u '//channel/property[@name=\"${_NAME}\"]/@value' -v '${_VALUE}'
#    -s '//channel[not(property/@name=\"${_NAME}\")]' -t elem -n property
#    -i '//channel/property[not(@name)]' -t attr -n 'name' -v '${_NAME}'
#    -i '//channel/property[not(@type)]' -t attr -n 'type' -v '${_TYPE}'
#    -i '//channel/property[not(@value)]' -t attr -n 'value' -v '${_VALUE}'
#  "
#done
#_XMLSTARLET_COMMAND+=" ${_XFCE_TERMINAL_CONFIG_FILE}"

_apply_i3(){
  i3-msg -q reload
}

# Try to apply theme to all applications in APPS
_apply (){
  for _app in "${_APPLY_APPS[@]}"; do
    echo "Applying ${_app}..."
    _FAIL=""

    case ${_app} in
      i3)
        _apply_i3 || _FAIL="x"
        ;;

      xfce4-terminal)
        _apply_xfce || _FAIL="x"
        ;;

      polybar)
        touch -m "${_CONFIG_DIR}/polybar/config" || _FAIL="x"
        ;;

      *)
        echo "Warn: Application ${_app} does not have an apply function. Skipping..." >&2
        ;;
    esac
    # fail only when known app fails
    if [ -n "${_FAIL}" ]; then echo "Error: Could not apply xresources to ${_app}. Skipping..." >&2; fi
  done
}


#output_app {
#  case ${1} in
#    xfce4-terminal)
#      TMP=$(mktemp)
#      if [ ! -f "${TMP}" ]; then
#        echo "Error: could not create temporary file. Skipping..."
#        return 1
#      fi
#      echo "[Scheme]" >> "${TMP}"
#      echo "Name=Xresources" >> "${TMP}"
#
#      xfcecolors "${TMP}"
#
#      # commit tmpfile
#      mv "${TMP}" "${OUTPUTDIR}/${XFCEOUTPUTNAME}"
#
#      if [ -f "${TMP}" ]; then
#        rm "${TMP}"
#      fi
#      ;;
#
#    *)
#      echo "Warn: Unsupported output ${1}. Skipping..." >&2
#      ;;
#  esac
#}

_usage (){
  printf "Usage: xresources.sh [OPTIONS]... [FILE]\n\n"
  printf "TODO write this shit properly\n\n"
  printf "OPTIONS:\n"
  #printf "  -a, --apply                [default] reload default Xresources file and refresh apps\n"
  printf "  -n, --no-xrdb              don't load any Xresources file with xrdb\n"
  printf "  -h, --help                 print this help\n"
  printf "  -p, --preset [PRESET]      use preset location (pywall, light, dark,...), overwrites -f\n"
  printf "  -f, --file [FILE]          specify Xresources file\n"
}

# ==================================================

# Options
_OPT_NO_XRDB=""
_OPT_OUTPUT=""
_OPT_PRESET=""
_OPT_FILE="${_XRES_DEFAULT_FILE}"
echo $_OPT_FILE

while (($#)); do
  case ${1} in 
    "-h" | "--help")
      _usage
      exit
      ;;
    "-p" | "--preset")
      shift
      _OPT_PRESET="${1}"
      if [ -z "${_OPT_PRESET}" ]; then
        echo "Error: --preset needs an argument. Exitting..." >&2
        exit 1
      fi
      shift
      ;;

    "-n" | "--no-xrdb")
      _OPT_NO_XRDB="true"
      shift
      ;;

    "-f" | "--file")
      shift
      _OPT_FILE="${1}"
      if [ -z "${_OPT_FILE}" ]; then
        echo "Error: --file needs an argument. Exitting..." >&2
        exit 1
      fi
      ;;

    *)
      _OPT_FILE="${1}"
      shift
      ;;
  esac
done

# Load ponential preset path
if [ -n "${_OPT_PRESET}" ]; then
  _OPT_FILE="${_XRES_PRESETS["${_OPT_PRESET}"]}"
fi

# Load Xresources file using xrdb if not asked not to
if [ -z "${_OPT_NO_XRDB}" ]; then
  echo "Loading ${_OPT_FILE}..."
  if ! xrdb -m "${_OPT_FILE}"; then echo "Error: xrdb failed. Exitting..." >&2; exit 1; fi
fi

# Load xrdb into memory
_XRDB="$(xrdb -q)"

# Apply settings to apps
_apply

echo "Done!"

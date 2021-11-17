#!/bin/bash

LIST_FILE="${HOME}/.config/wp/list"

print_presets(){
	for (( i=0; i<${#LIST[@]}; i+=2 )); do
		printf "${LIST[i]}\n"
	done
}

usage(){
	printf 'Usage: wp.sh [OPTION]... [PRESET]\n\n'
	printf 'Set backgrounds for multiple monitors using feh\n\n'
	printf 'OPTIONS:\n'
	printf '  -g, --gui                  use zenity to select a PRESET\n'
	printf '  -v, --view                 preview the backgrounds without making any changes\n'
	printf '  -f, --feh-flags [FLAGS]    feh will run with ONLY these arguments (overrides -n and -v)\n'
	printf "  -n, --no-save              don't modify ~/.fehbg when setting backgrounds\n"
	printf '  -p, --print-presets        print available PRESETs\n'
	printf '  -h, --help                 print this help\n'
	printf '\n'
	printf 'EXAMPLES:\n'
	printf '  wp.sh space_dark           Simple usage\n'
	printf "  wp.sh mc -f '--no-fehbg'   Don't modify ~/.fehbg\n"
	printf '  wp.sh --gui                Launch with zenity GUI\n'
	printf '\n'
	printf 'To add a PRESET just modify the LIST in this script.\n'
}

load_list(){
	if [[ -f "${LIST_FILE}" || -L "${LIST_FILE}" ]]; then
		eval "LIST=(`cat ${LIST_FILE}`)" # haha bash go brr
	else
		printf "ERR: ${LIST_FILE} not found!\n"
		printf "Create a template file in this location? (Y/n)"
		read A
		if [[ ${A} != "n" ]]; then
			printf "Creating ${LIST_FILE}...\n"
			printf "# Entries in the LIST are parsed and expanded by bash.
# See what you can get away with, but be careful for eval is used.
# A single PRESET in LIST:
#
# 'preset_name' '/path/to/file /newlines/are/ignored
# \"/quotes/and spaces are/good\" \"/wildcards/enable/folders/\"*\".jpg\" '
# 
# Yes, I could have used an associative array, but when
# displaying with zenity order of the PRESETs is lost.
# Example config:
'mac_day' '
	/media/blue/backgrounds/macOS/island_day.jpg
	/media/blue/backgrounds/macOS/desert_day.jpg
	/media/blue/backgrounds/macOS/coast_day.jpg
'
'using_a_folder' '
	\"/usr/share/backgrounds/archlinux/svalbard.jpg\"
	\"/usr/share/backgrounds/archlinux/\"*\".jpg\"
'" > "${LIST_FILE}"
		fi
		exit
	fi
}

select_preset(){
	# WP should contain paths to wallpaper as they would be written 
	# manually (expansion and spaces work too)

	# RANDOM
	if [ ! -z "${RND}" ]; then
		RANDOM=10#$(date +%N | cut -c1-6)
		WP="${LIST[(${RANDOM} % (${#LIST[@]} / 2)) * 2 + 1]}"

	# GUI
	elif [ ! -z "${GUI}" ]; then
		# warning if both GUI and argument selection was made
		if [ ! -z "${SEL}" ]; then printf "warning: ignoring '${SEL}' since -g was used.\n"; fi
		# check if we have zenity installed 
		if [ ! -x `command -v zenity` ]; then
			printf "GUI ERROR: zenity is missing execute permission or is not installed!\n"
			exit
		fi
		WP=$(zenity --list --title="Change wallpaper" --text "Change wallpaper" \
			--height=540 --column="Wallpaper" --column="command" \
			--print-column=2 --hide-column=2 --hide-header \
			-- "${LIST[@]}")

		# exit if no selection was made
		if [ -z "${WP}" ]; then exit; fi
	# CLI
	else
		# search for PRESET
		for (( i=0; i<${#LIST[@]}; i+=2 )); do
			if [ "${SEL}" == "${LIST[${i}]}" ]; then
				WP="${LIST[${i} + 1]}"
				break
			fi
		done
	fi
}

# Check if we have valid wallpaper files
apply_preset(){
	# Compile FEHFLAGS
	if [ -z "${FEHFLAGS}" ] && [ -z "${VIEW}" ]; then
		FEHFLAGS="--bg-fill"
		if [ ! -z "${NOSAVE}" ]; then 
			FEHFLAGS+=" --no-fehbg"
		fi
	fi
	# Apply
	if [ -z "${WP}" ]; then
		if [ -z "${SEL}" ]; then
			usage
		else
			printf "'${SEL}' is not a valid preset. To see valid presets, please use '-p'.\n"
		fi
	else
		# eval should be safe since we control what is in WP
		eval feh ${FEHFLAGS} ${WP}
	fi
}

# PROCESS ARGUMENTS
while (($#)); do
	case "${1}"	in
		"-r" | "--random") RND="BING"; shift;;
		"-g" | "--gui") GUI="ON"; shift;;
		"-f" | "--feh-flags") shift; FEHFLAGS="${1}"; shift;;
		"-n" | "--no-save") NOSAVE="JA"; shift;;
		"-v" | "--view") VIEW="DA"; shift;;
		"-p" | "--print-presets") load_list; print_presets; exit;;
		"-h" | "--help") usage; exit;;
		"-l" | "--list") shift; LIST_FILE="${1}"; shift;;
		*) SEL="${1}"; shift;;
	esac
done

load_list
select_preset
apply_preset

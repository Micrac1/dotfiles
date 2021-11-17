#!/bin/bash
LIST=(
	'~/bin/wp.sh -n mc ; gamemoderun minecraft-launcher' "Minecraft"
	'~/bin/wp.sh -n bh ; steam -applaunch 291550' "Brawlhalla"
	'~/bin/wp.sh -n dota ; steam -applaunch 570' "Dota 2"
	'~/bin/wp.sh -n csgo ; steam -applaunch 730' "CS:GO"
	'gamemoderun atlauncher' "ATLauncher"
	'gamemoderun xonotic-sdl' "Xonotic"
	'gamemoderun supertuxkart' "Super Tux Kart"

	'notify-send test1 ; notify-send test2 ; sleep 2s' "Test"
)


# depracted
get_game(){
	echo `zenity --list --title="Launch Game" --text "Launch Game" \
	--height=480 \
	--column="command" --column="Game" --hide-column=1 "${LIST[@]}"`  
}

run_game(){
	test -z "${1}" || gamemoderun "${GAME}" &
}

if [ "$1" = ]; then
	gui_select
else
	eval `get_game` &
	disown
fi


#GAME=`get_game`
#run_game "${GAME}"

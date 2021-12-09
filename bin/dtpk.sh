#!/bin/bash
#requires: grep, xinput 
#TODO: make the whole things more compatible with other computers
SEARCH=Touchpad #edit this to find your device 

# change( state, id)
change(){
	xinput set-int-prop "$2" "libinput Disable While Typing Enabled" 8 "$1"
}

getId(){
	id=$(xinput list | grep "$SEARCH" -m 1 | grep -E "id.*" -o | cut -c 4- | cut -f1)
	echo "$id"
}

id=$(getId)

if [ "$#" = "0" ]; then
	#if the binary is called with no arguments then it cycles between modes
	#check the current state
	x="$(xinput list-props "$id" | grep "Disable While Typing Enabled (")" #edit this to find your variable
	x="${x: -1}"
	
	#set new state (cycle)	
	if [ "$x" = "1" ]; then
		change "0" "$id"
		echo "Disabled touchpad protection"
	else
		change "1" "$id"
		echo "Enabled touchpad protection"
	fi
else
	#check arguments and execute accordingly
	if [ "$1" = "on" ];then
		change "1" "$id"
		echo "Enabled touchpad protection"
	elif [ "$1" = "off" ];then
		change "0" "$id"
		echo "Disabled touchpad protection"
	else
	#bad argument
		echo "Wrong parameter! use \"dtpk on\" or \"dtpk off\""
	fi
fi

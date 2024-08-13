#!/bin/bash

# Ultimate ricing script
# Applies background and xresources theme


usage (){
  printf "Easy ricing script that uses xresources.sh and wp.sh\n"
  printf "\n"

  printf "rice.sh [OPTIONS]...\n"
  printf "\n"
}

while (($#)); do
  case "${1}" in 
    "default")
      xresources.sh -p default
      wp.sh -n mac_day
      shift
      ;;
    "weeb") 
      xresources.sh ~/.config/xresources/weeb.Xresources
      wp.sh -n felix
      shift
      ;;
    "matrix") 
      xresources.sh ~/.config/xresources/matrix.Xresources
      wp.sh -n city
      shift
      ;;
    "-w" | "--wp")

      ;;
  esac
done

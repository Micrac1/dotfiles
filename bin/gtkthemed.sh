#!/bin/bash

XSETTINGS_CONFIG="/tmp/.xsettings"
GTK_INI="${HOME}/.config/gtk-3.0/settings.ini"

delete_theme(){
  echo '' > "${XSETTINGS_CONFIG}"
}

load_theme(){
  delete_theme
  for i in \
    'Net/ThemeName:gtk-theme-name'\
    'Net/IconThemeName:gtk-icon-theme-name'\
    'Gtk/CursorThemeName:gtk-cursor-theme-name'\
    'Net/SoundThemeName:gtk-sound-theme-name'\
    'Xft/Antialias:gtk-xft-antialias'\
    'Xft/DPI:gtk-xft-dpi'\
    'Xft/HintStyle:gtk-xft-hintstyle'\
    'Xft/Hinting:gtk-xft-hinting'\
    'Xft/RGBA:gtk-xft-rgba'\
    'Net/EnableInputFeedbackSounds:gtk-enable-input-feedback-sounds'\
    'Net/EnableEventSounds:gtk-enable-event-sounds'; do
      GTK_SET="$(grep "${i##*:}" "${GTK_INI}" | cut -d '=' -f 2)"
      [ -z "${GTK_SET}" ] || echo "${i%%:*} \"${GTK_SET}\"" >> ${XSETTINGS_CONFIG}


    #echo "${i%%:*} \"$(grep "${i##*:}" "${GTK_INI}" \
    #  | cut -d '=' -f 2)\"" >> ${XSETTINGS_CONFIG}
  done
  #echo "Net/ThemeName \"$(grep "gtk-theme-name" "${GTK_INI}" \
  #  | cut -d '=' -f 2)\"" > ${XSETTINGS_CONFIG}
  #echo "Net/IconThemeName \"$(grep "gtk-icon-theme-name" "${GTK_INI}" \
  #  | cut -d '=' -f 2)\"" >> ${XSETTINGS_CONFIG}
  #echo "Gtk/CursorThemeName \"$(grep "gtk-cursor-theme-name" "${GTK_INI}" \
  #  | cut -d '=' -f 2)\"" >> ${XSETTINGS_CONFIG}
  #echo "Gtk/CursorThemeName \"$(grep "gtk-cursor-theme-name" "${GTK_INI}" \
  #  | cut -d '=' -f 2)\"" >> ${XSETTINGS_CONFIG}
}

suicide(){
  [ -z "${IPID}" ] || kill -s SIGTERM "${IPID}"
  [ -z "${XPID}" ] || kill -s SIGTERM "${XPID}"
  exit
}

trap suicide SIGHUP SIGINT SIGTERM SIGHUP

pgrep xsettingsd && echo "INF: xsettingsd already running!" && killall xsettingsd

delete_theme

xsettingsd -c "${XSETTINGS_CONFIG}" &
XPID="$!"

load_theme

kill -s SIGHUP "${XPID}"


while true; do
  inotifywait -qq -e attrib "${GTK_INI}" &
  IPID="$!"
  wait "${IPID}"
  delete_theme
  kill -s SIGHUP "${XPID}"
  load_theme
  kill -s SIGHUP "${XPID}"
done

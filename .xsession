# Autostart apps on all xsessions

# XRDB
xrdb -merge "${HOME}/.config/xresources/Xresources"

# Gnome polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# ende
if [ "${HOSTNAME}" = "ende" ]; then
  # Monitor layout
  "${HOME}/.config/screenlayout/triple.sh"

  # Udiskie automount
  udiskie -a -n -t &

  # Desktop notifications
  /usr/bin/dunst &

  # NetworkManager applet
  /usr/bin/nm-applet &

  # Volume applet
  /usr/bin/pasystray &

  # Clipboard manager (add --no-icon to disable system tray)
  /usr/bin/parcellite &

  # Graphics tablet setup
  "${HOME}/bin/tablet.sh"

  # Discord
  "${HOME}/bin/discord.sh" &

  # Polybar // TODO move to i3-only session
  "${HOME}/.config/polybar/launch_polybar.sh" &

  # Alt-Tab
  /usr/bin/alttab -s 0 &
fi

# Background
if [ -x "${HOME}/.fehbg" ]; then "${HOME}/.fehbg"; fi

# Numlock on
/usr/bin/numlockx on

# Keyboard layout
/usr/bin/setxkbmap -option grp:alt_shift_toggle "us,sk" -variant ",qwerty"

# Xmodmap
/usr/bin/xmodmap "${HOME}/.config/Xmodmap"

# Picom
/usr/bin/picom --experimental-backends &

# Welcome
"${HOME}/bin/welcome.sh && ${SHELL}" &

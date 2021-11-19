# Autostart apps on all xsessions

# XRDB
xrdb "${HOME}/.config/xresources/Xresources"

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
fi

# Background
if [ -x "${HOME}/.fehbg" ]; then "${HOME}/.fehbg"; fi

# Numlock on
/usr/bin/numlockx on

# Keyboard layout
/usr/bin/setxkbmap -option grp:alt_shift_toggle us,sk

# Xmodmap
/usr/bin/xmodmap "${HOME}/.config/Xmodmap"

# Autostart apps on all xsessions

# XRDB
/bin/xrdb -merge "${HOME}/.config/xresources/Xresources"

# ende
if [ "${HOSTNAME}" = "ende" ]; then
  # Monitor layout
  "${HOME}/.config/screenlayout/triple.sh"

  # Graphics tablet setup
  "${HOME}/.dfs/session/tablet.sh"

  # Discord
  #"${HOME}/bin/discord.sh" &

  # Picom
  /bin/picom &
fi

# clamp
if [ "${HOSTNAME}" = "clamp" ]; then
  # Natural touchpad scrolling
  /bin/xinput set-prop "ELAN0662:00 04F3:30BC Touchpad" "libinput Natural Scrolling Enabled" 1

  # Power manager
  #/bin/xfce4-power-manager &

  # Touchpad gestures
  /bin/pgrep -f -- "/bin/touchegg --client" || /bin/touchegg --client &
fi

# Bluetooth manager
/bin/blueman-applet &

# Gnome polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Volume applet
/bin/pasystray &

# Udiskie automount
/bin/udiskie -a -n -t &

# NetworkManager applet
/bin/nm-applet &

# Clipboard manager (add --no-icon to disable system tray)
/bin/parcellite &

# Desktop notifications
/bin/dunst &

# Polybar
#"${HOME}/.config/polybar/launch_polybar.sh"

# Background
if [ -x "${HOME}/.fehbg" ]; then "${HOME}/.fehbg"; fi

# Keyboard
"${HOME}/.dfs/session/keyboard.sh"

# Screen locker
"${HOME}/.dfs/session/locker.sh"

# Welcome
"${HOME}/.dfs/session/welcome.sh && ${SHELL}" &

# Autostart apps on all xsessions

# XRDB
/bin/xrdb -merge "${HOME}/.config/xresources/Xresources"

# ende
if [ "${HOSTNAME}" = "ende" ]; then
  # Monitor layout
  "${HOME}/.config/screenlayout/triple.sh"

  # Graphics tablet setup
  "${HOME}/bin/tablet.sh"

  # Discord
  "${HOME}/bin/discord.sh" &

  # Alt-Tab
  #/bin/alttab -s 0 &
fi

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

# Polybar // TODO move to i3-only session
"${HOME}/.config/polybar/launch_polybar.sh"

# Background
if [ -x "${HOME}/.fehbg" ]; then "${HOME}/.fehbg"; fi

# Numlock on
/bin/numlockx on

# Keyboard layout
/bin/setxkbmap -option keypad:pointerkeys -option grp:alt_shift_toggle "us,sk" -variant ",qwerty"

# Xmodmap
/bin/xmodmap "${HOME}/.config/Xmodmap"

# Automatic lockscreen after xset delay
LOCK_TIMEOUT=295
LOCK_DIM_DURATION=5

/bin/xset s "${LOCK_TIMEOUT}" "${LOCK_DIM_DURATION}"
/bin/xset s blank
/bin/xset s noexpose
/bin/env \
    XSECURELOCK_WAIT_TIME_MS=0 \
    XSECURELOCK_DIM_ALPHA=1 \
    XSECURELOCK_DIM_TIME_MS="${LOCK_DIM_DURATION}000" \
    XSECURELOCK_SAVER=saver_blank \
    XSECURELOCK_AUTH_TIMEOUT=5 \
    XSECURELOCK_BLANK_TIMEOUT=1 \
    XSECURELOCK_PASSWORD_PROMPT=disco \
    XSECURELOCK_BLANK_DPMS_STATE=off \
    XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 \
  /bin/xss-lock -l -n /usr/lib/xsecurelock/dimmer \
  -- /bin/xsecurelock &

# Picom
#/bin/picom &

# Welcome
"${HOME}/bin/welcome.sh && ${SHELL}" &

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

  # Alt-Tab
  /usr/bin/alttab -s 0 &
fi

# Polybar // TODO move to i3-only session
"${HOME}/.config/polybar/launch_polybar.sh"

# Background
if [ -x "${HOME}/.fehbg" ]; then "${HOME}/.fehbg"; fi

# Numlock on
/usr/bin/numlockx on

# Keyboard layout
/usr/bin/setxkbmap -option keypad:pointerkeys -option grp:alt_shift_toggle "us,sk" -variant ",qwerty"

# Xmodmap
/usr/bin/xmodmap "${HOME}/.config/Xmodmap"

# Automatic lockscreen after xset delay
LOCK_TIMEOUT=295
LOCK_DIM_DURATION=5
xset s "${LOCK_TIMEOUT}" "${LOCK_DIM_DURATION}"
xset s blank
xset s noexpose
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
  xss-lock -l -n /usr/lib/xsecurelock/dimmer \
  -- /bin/xsecurelock &

# Picom
/usr/bin/picom --experimental-backends &

# Welcome
"${HOME}/bin/welcome.sh && ${SHELL}" &

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
  #"${HOME}/bin/discord.sh" &
fi

# clamp
if [ "${HOSTNAME}" = "clamp" ]; then
  # Natural touchpad scrolling
  /bin/xinput set-prop "ELAN0662:00 04F3:30BC Touchpad" "libinput Natural Scrolling Enabled" 1

  # Power manager
  #/bin/xfce4-power-manager &

  # Touchpad gestures
  /bin/pgrep -f -- "/bin/touchegg --client" || /bin/touchegg --client &

  # Bluetooth manager
  /bin/blueman-applet &
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

# Polybar
#"${HOME}/.config/polybar/launch_polybar.sh"

# Background
if [ -x "${HOME}/.fehbg" ]; then "${HOME}/.fehbg"; fi

# Numlock on
/bin/numlockx on

# Keyboard layout
/bin/setxkbmap -option keypad:pointerkeys -option grp:alt_shift_toggle "us,sk" -variant ",qwerty"

# Key repeat delay
/bin/xset r rate 300 25

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

# Set correct scroll lock to indicate mute status
"${HOME}/bin/mute.sh" -s

# Welcome
"${HOME}/bin/welcome.sh && ${SHELL}" &

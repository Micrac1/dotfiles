#!/bin/sh

# Numlock on
/bin/numlockx on

# Keyboard layout
/bin/setxkbmap -option keypad:pointerkeys -option grp:alt_shift_toggle "us,sk" -variant ",qwerty"

# Key repeat delay
/bin/xset r rate 300 25

# Xmodmap
/bin/xmodmap "${HOME}/.config/Xmodmap"

# Set correct scroll lock to indicate mute status
"${HOME}/.dfs/bin/mute.sh" -s

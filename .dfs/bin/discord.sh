#!/bin/bash
if [ -n "$1" ]; then
  case "$1" in
    "web" | "-w")
      chromium --app=https://discord.com/app
    ;;
  "canary" | "-c")
    discord-canary
    ;;
  "discord" | "-d")
    discord
    ;;
  esac
else
  firefox --new-window "https://discord.com/app"
  #chromium --app=https://discord.com/app
  #discord
  #discord-canary
fi

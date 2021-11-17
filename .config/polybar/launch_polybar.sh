#!/bin/bash

killall polybar

if [ "$1" != "-t" ]; then
	exec >/dev/null 2>&1
fi

if type "xrandr" 1>/dev/null ; then
	if (xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1); then
		for m in $(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1); do
			MONITOR=$m polybar --reload secondary &
		done
		MONITOR=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1) polybar --reload primary &
	else
		for m in $(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1); do
			MONITOR=$m polybar --reload primary &
		done
	fi
else
  polybar --reload primary &
fi

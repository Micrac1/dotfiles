#!/bin/bash
Xephyr :1 -dpi 96 +iglx -no-host-grab -br -ac -noreset -screen 1920x1080 &
sleep 1
blackbox -display :1 &

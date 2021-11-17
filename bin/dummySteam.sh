#!/bin/sh
xhost +local:
su dummy -c 'export DISPLAY=:0; steam'

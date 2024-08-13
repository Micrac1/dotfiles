#!/bin/sh

SERVERNAME="ivimserver"

if vim --serverlist | grep -E -i -q "^${SERVERNAME}$"; then
	vim --servername "${SERVERNAME}" --remote-tab-silent "$@"
else
	xfce4-terminal -x vim --servername "${SERVERNAME}" --remote-tab-silent "$@" &
fi

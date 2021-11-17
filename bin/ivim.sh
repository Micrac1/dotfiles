#!/bin/sh

SERVERNAME="ivimserver"
if [ ! -z "${1}" ]; then
	SERVERNAME="${1}"
fi

shift
if vim --serverlist | egrep -i -q "^${SERVERNAME}$"; then
	vim --servername "${SERVERNAME}" --remote-tab-silent "$@"
else
	xfce4-terminal --disable-server -x vim --servername "${SERVERNAME}" --remote-tab-silent "$@" &
fi

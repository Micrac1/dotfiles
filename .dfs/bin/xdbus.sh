#!/bin/bash

if [ -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
	export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${UID}/bus" 
fi

if [ -z "$1" ]; then
	echo "Entering shell with dbus..."
	bash
else
	$@
fi

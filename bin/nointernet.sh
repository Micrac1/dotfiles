#!/bin/sh
# SETUP
# groupadd nointernet
# usermod -G nointernet peter

# Enabling local network access
# iptables -A OUTPUT -m owner --gid-owner no-internet -d 192.168.1.0/24 -j ACCEPT
# iptables -A OUTPUT -m owner --gid-owner no-internet -d 127.0.0.0/8 -j ACCEPT
# iptables -A OUTPUT -m owner --gid-owner no-internet -j DROP
RULE="-m owner --gid-owner nointernet -j DROP"
if [ "$1" == "-s" ]; then
	sudo iptables -C OUTPUT $RULE || sudo iptables -I OUTPUT 1 $RULE
elif [ "$1" == "" ]; then
	printf "Entering internet free shell...\n"
	sg nointernet
else
	TMP="$@" # bash magic, does not work directly
	sg nointernet -c "$TMP"
fi

#!/bin/sh
killall gpg-agent
echo "1234" | gpg -o /dev/null --local-user "${1}" -as - && echo "The correct passphrase was entered for this key"

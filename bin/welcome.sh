#!/bin/sh

# Greeting
echo "  Welcome back ${USER}!"

# Date
printf '📅 '
LC_TIME=en_DK.UTF-8 date +'%d-%m-%Y, %A'

# Nameday
printf '📆 '
curl -X POST "https://nameday.abalin.net/api/V1/today" \
	-H "Content-Type: application/json" \
	-H "Accept: application/json" \
	-d '{"country":"sk","timezone":"Pacific\/Palau"}' -s | jq '.nameday.sk' -r

# Time
printf '🕑 '
LC_TIME=en_DK.UTF-8 date +'%H:%M'

# Weather
curl wttr.in/Bratislava?format="%c+%t\n"

# Updates
updateCount=$(checkupdates | wc -l)
if [ "$updateCount" -eq "0" ]; then
	echo "No updates"
else
	echo "$updateCount new updates!"
fi

# Print todo
printf '\n✓ TODO:\n'
cat "${HOME}/Documents/TODO.txt"

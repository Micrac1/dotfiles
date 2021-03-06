#!/bin/sh

# Greeting
echo "ļ¼  Welcome back ${USER}!"

# Date
printf 'š '
LC_TIME=en_DK.UTF-8 date +'%d-%m-%Y, %A'

# Nameday
printf 'š '
curl -X POST "https://nameday.abalin.net/today" \
	-H "Content-Type: application/json" \
	-H "Accept: application/json" \
	-d '{"country":"slovakia","timezone":"Pacific\/Palau"}' -s | jq '.data.namedays.sk' -r

# Time
printf 'š '
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
printf '\nā TODO:\n'
cat "${HOME}/Documents/TODO.txt"

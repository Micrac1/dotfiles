#!/bin/bash
# Settings
# Steam token API 
TOKEN=$(cat "${HOME}/.config/secrets/steam_token")

# Include games, software, hardware, videos and stuff
I_GAMES="1"

# Create database of steam ids
LAST_APPID="0"

DB_PATH="${HOME}/.cache/steamdb.json"
MAX_RESULTS=5


#jq '.response.last_appid' steamdb.json

UNREFINED_DB=`mktemp`
echo "" > "${DB_PATH}"
#ITERATION_TMP=`mktemp`

# Create a big chonkin' db

while [[ "${LAST_APPID}" != "null" ]]; do

jq '.[]' \
<(curl -s -H "Accept: application/json" 'https://api.steampowered.com/IStoreService/GetAppList/v1/'\
'?access_token='"${TOKEN}"'&include_games='"${I_GAMES}"\
'&last_appid='"${LAST_APPID}"'&max_results='"${MAX_RESULTS}") "${DB_PATH}" >> "${DB_PATH}"

	LAST_APPID=`jq -c -r '.last_appid' "${DB_PATH}"`
	printf "${LAST_APPID}"
	#LAST_APPID="null"
	#echo "${LAST_APPID}"
done


rm ${UNREFINED_DB}

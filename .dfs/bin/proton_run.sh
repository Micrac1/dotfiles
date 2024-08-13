#!/bin/sh

export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/steam"
export STEAM_COMPAT_DATA_PATH="/media/blue/steam_games/steamapps/compatdata/1325860"

'/opt/steam_games/steamapps/common/Proton 7.0'/proton run '/media/blue/steam_games/steamapps/common/VTube Studio/VTube Studio.exe' -nosteam
exit

# Steam / IDs
export SteamAppId=""
export SteamGameId=""

# Steam / Client path
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/steam"

# Steam / Compat data path
export STEAM_COMPAT_DATA_PATH="$STEAM_APPS_PATH/compatdata/$SteamAppId"

# Proton / Path
PROTON_PATH="$STEAM_APPS_PATH/common/Proton 4.11"

# Proton / Executable script
PROTON_EXEC="$PROTON_PATH/proton"

"$PROTON_EXEC" run $@

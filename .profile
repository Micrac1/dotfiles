export PATH="${PATH}:${HOME}/.local/bin"
export QT_QPA_PLATFORMTHEME=qt5ct
# export SDL_GAMECONTROLLERCONFIG="0300f2005e040000a102000014010000,Xbox 360 Wireless Receiver (XBOX),a:b0,b:b1,back:b6,dpdown:b14,dpleft:b11,dpright:b12,dpup:b13,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux"

# Avoid cluttering $HOME
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

export ANDROID_USER_HOME="${XDG_DATA_HOME}/android"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export __GL_SHADER_DISK_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
export MINETEST_USER_PATH="${XDG_DATA_HOME}/minetest"
export NUGET_PACKAGES="${XDG_CACHE_HOME}/NuGetPackages"
export OMNISHARPHOME="${XDG_CONFIG_HOME}/omnisharp"
export PYTHON_HISTORY="${XDG_STATE_HOME}/python/.python_history"
export RENPY_PATH_TO_SAVES="${XDG_DATA_HOME}/renpy"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export W3M_DIR="${XDG_DATA_HOME}/w3m"


# Unused, enable if they pop up
# export MATHEMATICA_USERBASE="$XDG_CONFIG_HOME"/mathematica

[ -n "$BASH_VERSION" ] && [ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"

#
# ~/.bashrc
#

# Exports for some funny apps
export QT_QPA_PLATFORMTHEME=qt5ct
export HISTFILESIZE=-1
export HISTSIZE=-1

set colored-stats on

# If not running interactively, don't do anything
[ ${-#*i} != ${-} ] || return

PATH="${PATH}:${HOME}/bin"

# Reset character
_RES='\[\e[0m\]'

# GIT PROMPT SUPPORT
GIT_PS1="1"
if [ -f "/usr/share/git/completion/git-prompt.sh" ]; then
  . "/usr/share/git/completion/git-prompt.sh"
  # ignore when we are in home dir repo
  _GIT_PS1='$( [ "${GIT_PS1}" = "1" ] \
    && ! findmnt . 2>/dev/null >/dev/null \
    && [ ! "${HOME}" = "$(git rev-parse --show-toplevel 2>/dev/null)" ] \
    && __git_ps1 " (\001\e[01;33m\002%s'"${_RES}"')" \
  )'
  export GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWUPSTREAM="verbose"
else
  _GIT_PS1=""
fi

# Shell prompt (color and character)
if [ "$(id -gn)" = "nointernet" ]; then
	_PROMPT='!'
	_COLOR="\001\e[01;33m\002"
else
	_PROMPT='\$'
	_COLOR="\001\e[01;32m\002"
fi

# DBUS status color
if [ -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
	_C_DBUS="\001\e[01;97m\002" 
else
  _C_DBUS="${_COLOR}"
fi

# Login shell indicator
if shopt -q login_shell; then
  _LOGIN="\001\e[01;36m\002"
else
  _LOGIN="${_COLOR}"
fi

PS1=\
"${_RES}${_COLOR}[${_LOGIN}\u"\
'$(test "$?" -eq 0 && echo "\001\e[01;32m\002" || echo "\001\e[01;31m\002")'"@\
${_COLOR}\h ${_RES}\W${_COLOR}]${_RES}\
${_GIT_PS1}${_C_DBUS}${_PROMPT}${_RES} "

unset _COLOR _PROMPT _RES _GIT_PS1 _C_DBUS

# Aliases
alias ls='ls --color=auto'
alias ll="ls -lav --block-size=\"'1\" --ignore=.."
alias l="ls -lav --block-size=\"'1\" --ignore=.?*"
alias t='xfce4-terminal &'
alias cim="vim --cmd 'set clipboard=unnamed'"
alias v='vim'
alias j='jrnl'
alias clip='xclip -i -sel clipboard'
alias s='pkgfile -v -b'
alias bel='echo -e -n "\007"'
alias mv="mv -i"

# pacman stuff
alias pi='pacman -Qi'
alias p='pacman'

# DONT RUN UNDER ROOT
[ "$(whoami)" = "root" ] && return

# limits recursive functions, see 'man bash'
[ -z "$FUNCNEST" ] && export FUNCNEST=100

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

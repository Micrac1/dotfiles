#
# ~/.bashrc
#

# Exports for some funny apps
export HISTFILESIZE=-1
export HISTSIZE=-1
export HISTFILE="${HOME}/.bashhistory"

# If not running interactively, don't do anything
[ ${-#*i} != ${-} ] || return

# This thing breaks session loading when sourced from .profile
set colored-stats on

PATH="${PATH}:${HOME}/.dfs/bin"
case ${TERM} in
  st*|Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|tmux*|xterm*)
    PROMPT_COMMAND+=('printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
esac

# Reset character
_RES='\[\e[0m\]'
_RED='\[\e[01;31m\]'

# GIT PROMPT SUPPORT
GIT_PS1="1"
if [ -f "/usr/share/git/completion/git-prompt.sh" ]; then
  . "/usr/share/git/completion/git-prompt.sh"
  # ignore when we are in home dir repo
  _GIT_PS1='$( [ "${GIT_PS1}" = "1" ] \
    && ! findmnt . 2>/dev/null >/dev/null \
    && [ ! "${HOME}" = "$(git rev-parse --show-toplevel 2>/dev/null)" ] \
    && __git_ps1 " (\[\e[01;33m\]%s'"${_RES}"')" \
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
	_COLOR="${_RED}"
else
	_PROMPT='\$'
	_COLOR="\[\e[01;32m\]"
fi

# DBUS status color
if [ -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
	_C_DBUS="\[\e[01;97m\]"
else
  _C_DBUS="${_COLOR}"
fi

# Login shell indicator
if shopt -q login_shell; then
  _LOGIN="\[\e[01;36m\]"
else
  _LOGIN="${_COLOR}"
fi

PROMPT_COMMAND=\
'EC=$?;'\
'PS1="'\
"${_RES}${_COLOR}[${_LOGIN}\u"\
'$([ "${EC}" -eq 0 ] || echo "'${_RED}'")@'\
"${_COLOR}\h${_RES} \W${_COLOR}]${_RES}"\
"${_GIT_PS1}"\
'$([ "${EC}" -eq 0 ] || echo " '${_RED}'(${EC})${_RES}")'\
"${_C_DBUS}${_PROMPT}${_RES} "\
'"'

unset _COLOR _PROMPT _RES _GIT_PS1 _C_DBUS _RED

declare -A BASHMARKS
case "$(hostname)" in
  "ende")
    BASHMARKS["mato"]="/media/blue/projects/doucovanie/Mato/python/python_assignments"
    BASHMARKS["mc"]="/media/blue/mc_servers"
    BASHMARKS["projects"]="/media/blue/projects"
    BASHMARKS["sources"]="/media/blue/sources"
    BASHMARKS["vm"]="/media/blue/vm"
    BASHMARKS["artemis"]="/media/blue/projects/artemis"
    ;;
  "clamp")
    BASHMARKS["projects"]="${HOME}/projects"
    BASHMARKS["sources"]="${HOME}/sources"
    BASHMARKS["vm"]="${HOME}/vm"
    BASHMARKS["artemis"]="${HOME}/projects/artemis"
    ;;
esac

g(){
  TMP="${BASHMARKS[${1- }]}"
  if [ -z "${1}" ]; then
    echo "Current bookmarks:"
    echo "${!BASHMARKS[@]}"
  elif [ -z "${TMP}" ]; then
    echo "Bashmark '${1}' does not exist"
  else
    cd $TMP
  fi
}

# Aliases
alias sway="sway --unsupported-gpu"
alias ncdu="ncdu --color dark"
alias ls='ls --color=auto'
alias ll="ls -lav --block-size=\"'1\" --ignore=.."
alias l="ls -lav --block-size=\"'1\" --ignore=.?*"
alias t='xfce4-terminal &'
alias cim="vim --cmd 'set clipboard=unnamed'"
alias v='vim'
alias vi='vim'
alias nv='nvim'
alias nvi='nvim'
alias note='vim "${HOME}/Sync/notes.md"'
alias not="note"
alias no="note"
alias clip='xclip -i -sel clipboard'
alias bel='echo -e -n "\007"'
alias c="cpupower-gui"
alias mv="mv -i"

# Aliases (configs)
alias _bash="vim ~/.bashrc"
alias _profile="vim ~/.profile"
alias _vim="vim ~/.vim/vimrc"
alias _i3="vim ~/.config/i3/config"
alias _polybar="vim ~/.config/polybar/config.ini"
alias _xresources="vim ~/.config/xresources/Xresources"

# pacman stuff
alias p='pacman'
alias sp='sudo pacman'
alias s='pkgfile -v -b'
alias qi='pacman -Qi'
alias si="pacman -Si"
alias ss="pacman -Ss"

# Completion for aliases
_completion_loader pacman
_TMP="$(complete -p pacman)" && eval "${_TMP% *} p"
_TMP="$(complete -p pacman)" && eval "${_TMP% *} sp"

. "${HOME}/.dfs/init.sh"

# limits recursive functions, see 'man bash'
[ -z "$FUNCNEST" ] && export FUNCNEST=100

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\C-w":vi-unix-word-rubout'

#/bin/sh
alias dit='git --work-tree="${HOME}" --git-dir="${HOME}/.dfs/.git"'
alias ditk='GIT_DIR="${HOME}/.dfs/.git" gitk'

if [ -n "${BASH_VERSION}" ]; then
  _completion_loader git
  _TMP="$(complete -p git)" && eval "${_TMP% *} dit"
  _TMP="$(complete -p gitk)" && eval "${_TMP% *} ditk"
fi

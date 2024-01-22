#/bin/sh
set -e
DFS_DIR="${HOME}/.dfs"

update_arch(){
  echo ": Detected pacman, installing pacman_packages.txt..."
  sudo pacman -Syyu --needed -- \
    $(sed '/\(^\s*#.*$\|^$\)/d' -- "${DFS_DIR}/pacman_packages.txt")
}

if pacman --version >/dev/null; then
  update_arch
  exit 0
fi

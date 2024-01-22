# Dotfiles

**[Installation](#installation)** | **[Screenshots](#screenshots)**

My very own dotfiles. Feel free to right-click and save.

|TO|DO|
|-|-|
|Theming|[Xresources](#xresources)|
|Window manager|[i3](#i3)|
|Bar|[Polybar](#polybar)|
|Text editor|[Vim](#vim)|
|Terminal emulator|xfce4-terminal|
|Shell|[Bash](#bash)|

## Configs

### Xresources
[Xresources](.config/xresources/Xresources)

#### xresources.sh

### i3
**[config](.config/i3/config)** | (also see [Xresources](#xresources))

### Polybar
**[config.ini](.config/polybar/config.ini)** (also see [Xresources](#xresources))

### Vim
**[vimrc](.vim/vimrc)**
- Plugin manager: [vim-plug](https://github.com/junegunn/vim-plug)

#### Plugins

### xfce4-terminal
see [xresources.sh](#xresources.sh)

### Bash
**[bashrc](.vim/vimrc)** | **[profile](.profile)**

### Scripts

### Programs

---

## Prerequisites
- Arch based distro (for package install)
- Directory/file `$HOME/.dfs` should not exist (`rm -rf "${HOME}/.dfs"`)
- Internet connection (repo clone + package install + some app install)
- git (obviously)

## Installation

Make sure that there is no `$HOME/.dfs` directory, otherwise this will not run.

```sh
[ ! -d "${HOME}/.dfs" ] && \
git clone --no-checkout http://github.com/Micrac1/dotfiles -- "${HOME}/.dfs" && \
git --git-dir="${HOME}/.dfs/.git" --work-tree="${HOME}" reset >/dev/null && \
git --git-dir="${HOME}/.dfs/.git" --work-tree="${HOME}" checkout -- .dfs && \
"${HOME}/.dfs/scripts/dfs_first_setup.sh"
```

Explanation:
- Clone the repo without overwriting any files inside `$HOME` (except `.dfs`)
- Set state to master (actually creates the files)
- Source helper functions/aliases


## Screenshots
### TODO

#/bin/sh
set -e
[ -z "${DFS_NO_FIRST_SETUP}" ]
DFS_DIR="${HOME}/.dfs"
_GD='--git-dir='"${DFS_DIR}"'/.git'
_WT='--work-tree='"${HOME}"

yesno() {
  _PROMPT="[y/n]"
  case "${2}" in "y") _PROMPT="[Y/n]";; "n") _PROMPT="[y/N]";; esac
  while true; do
    read -p "${1} ${_PROMPT}: "
    echo
    case "${REPLY}" in [Yy]*) return 0 ;; [Nn]*) return 1 ;; 
      "") case "${2}" in "y") return 0;; "n") return 1;; esac
    esac
  done
}

echo

echo "============================================================"
echo "=================== File installation ======================"
echo "============================================================"
echo "= Congratulations! DFS repo has been successfully cloned!  ="
echo "= Now you can begin by selecting what file you want to     ="
echo "= install.                                                 ="
echo "============================================================"
if yesno ">> Would you like to install files from the repo?" y; then
  echo "# Looking for conflicting files..."
  _CONFLICTS="$(git "${_GD}" "${_WT}" diff --name-only --diff-filter=M)"
  if [ -n "${_CONFLICTS}" ]; then
    echo "# Found conflicting files:"
    echo "${_CONFLICTS}" # TODO print with prefix (|)
  else
    echo "# No conflicting files!"
  fi

  while true; do
  echo "@__________________________________________________________@"
    echo "@   all        - INSTALL OVER ALL CONFLICTING FILES        @"
    if [ -n "${_CONFLICTS}" ]; then
      echo "@   skip       - Skip conflicting files                    @"
    fi
    echo "@   none       - Do not install any files                  @"
    echo "@   choose     - Choose for every file"
    read -p ">> What files would you like to install?: "

    case "${REPLY}" in 
      "all")
        git "${_GD}" "${_WT}" reset --hard
        break
        ;;
      [n])
        break
        ;;
      [s])
        if [ -n "${_CONFLICTS}" ]; then
          git "${_GD}" "${_WT}" checkout -- \
            $(git "${_GD}" "${_WT}" ls-files --deleted)
          break
        fi
        ;;
      [c])
        IFS=$'\n'
        _INSTALL_REST=""
        _SKIP_REST=""
        _MODIFIED_DELETED="$(git "${_GD}" "${_WT}" ls-files --modified)"
        for F in ${_MODIFIED_DELETED}; do
          [ -n "${_SKIP_REST}" ] && break
          if [ -n "${_INSTALL_REST}" ]; then
            if [ -n "${_INSTALL_REST_CONSKIP}" ] && \
              [ -z "$(git "${_GD}" "${_WT}" ls-files --deleted "${F}")" ]; then
              echo "# Skipping ${F}"
            else
              echo "# Installing ${F}"
              git "${_GD}" "${_WT}" checkout -- "${F}"
            fi
            continue
          fi

          _CONF="$(git "${_GD}" "${_WT}" ls-files --deleted "${F}")"
          while true; do
            echo
            if [ -z "${_CONF}" ]; then
              echo "# File: ${F}"
            echo "@_[Conflict!]______________________________________________@"
            else
              echo "# File: ${F}"
            echo "@__________________________________________________________@"
            fi
            echo "@   install    - Install this file                         @"
            echo "@   skip       - Do not install this file                  @"
            echo "@   quit       - Skip the rest                             @"
            echo "@   all        - Install the rest                          @"
            echo "@   conskip    - Install the rest (skip conflicting)       @"
            read -p ">> What to do with the following file?: "
            case "${REPLY}" in
              "all")
                _INSTALL_REST="yes"
                echo "# Installing the rest..."
                break
                ;;
              [s])
                echo "# Skipping ${F}"
                break
                ;;
              [i])
                echo "# Installing ${F}"
                git "${_GD}" "${_WT}" checkout -- "${F}"
                break
                ;;
              [q])
                _SKIP_REST="yes"
                echo "# Skipping the rest..."
                break
                ;;
              [c])
                _INSTALL_REST="yes"
                _INSTALL_REST_CONSKIP="yes"
                echo "# Installing the rest (skipping conflics)..."
                break
                ;;
            esac
          done
        done
        break
        ;;
    esac
  done
fi

echo "============================================================"
echo "= Files installation completed!                            ="
echo "============================================================"

echo

echo "============================================================"
echo "===================== System update ========================"
echo "============================================================"
echo "= This will install all needed packages (requires sudo)    ="
echo "=                                                          ="
echo "============================================================"
if yesno ">> Run system update?" y; then
  "${DFS_DIR}/scripts/dfs_system_update.sh" || \
    yesno ">> System update failed. Continue anyway?" n
fi

echo "============================================================"
echo "= System update complete!                                  ="
echo "============================================================"

echo

echo "============================================================"
echo "=============== Application setup scripts =================="
echo "============================================================"
echo "= Some applications have scripts to set them up, like      ="
echo "= installing plugins, downloading databases, etc.          ="
echo "============================================================"
if yesno ">> Run application setup scrips?" y; then
  "${DFS_DIR}/scripts/dfs_application_setup.sh" || \
    yesno ">> Application setup scripts failed. Continue anyway?" n
fi


echo "============================================================"
echo "= Application setup scripts complete!                      ="
echo "============================================================"


echo

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "= Setup complete! Please relog to see all changes          ="
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

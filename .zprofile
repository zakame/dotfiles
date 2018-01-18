LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

export LANG LC_ALL

typeset -U path

if [ -e ${ZDOTDIR:-$HOME}/.zprofile.local ]; then
    source ${ZDOTDIR:-$HOME}/.zprofile.local
fi

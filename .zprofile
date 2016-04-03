typeset -U path

if [ -e ${ZDOTDIR:-$HOME}/.zprofile.local ]; then
    source ${ZDOTDIR:-$HOME}/.zprofile.local
fi

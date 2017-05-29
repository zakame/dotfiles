LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

export LANG LC_ALL

# for Emacs TRAMP and friends that need no line editing
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# load any local configuration
if [ -f $HOME/.zshenv.local ]; then
    source $HOME/.zshenv.local
fi

typeset -U path

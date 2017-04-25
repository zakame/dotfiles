LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

export LANG LC_ALL

# load any local configuration
if [ -f $HOME/.zshenv.local ]; then
    source $HOME/.zshenv.local
fi

typeset -U path

LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8

ALTERNATE_EDITOR=""
VISUAL="emacsclient"
alias ec="$VISUAL -c"
alias e=$VISUAL

if [ -d $HOME/bin ]; then
  PATH=$HOME/bin:$PATH
fi

LESS="-R"

export LANG LC_ALL ALTERNATE_EDITOR VISUAL LESS PATH

# load any local configuration
if [ -f $HOME/.zprofile.local ]; then
    source $HOME/.zprofile.local
fi

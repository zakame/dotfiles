# load antigen if it is available
if [ -r $HOME/src/antigen/antigen.zsh ]; then
    source $HOME/src/antigen/antigen.zsh
    antigen use oh-my-zsh
    antigen bundles <<EOF
zsh-users/zsh-syntax-highlighting
adb
bower
bundler
cabal
coffee
colored-man-pages
composer
cp
cpanm
docker
docker-compose
emacs
frontend-search
gem
git
golang
gradle
history
history-substring-search
jsontools
laravel5
lein
node
npm
nyan
perl
pip
pyenv
python
rails
rake
rake-fast
rbenv
systemadmin
tmux
torrent
vim-interaction
web-search
EOF
    if [ -x /usr/bin/gpg-agent ]; then
        antigen bundle gpg-agent
    fi
    bindkey -M emacs '^P' history-substring-search-up
    bindkey -M emacs '^N' history-substring-search-down
fi

# load liquidprompt if available
if [ -r $HOME/src/liquidprompt/liquidprompt ]; then
    source $HOME/src/liquidprompt/liquidprompt
elif [ -r $HOME/src/antigen/antigen.zsh ]; then
    # or fall back to antigen theme
    antigen theme minimal
fi

# prefer plenv to perlbrew if both are found
if [ -d $HOME/.plenv ]; then
    PATH=$HOME/.plenv/bin:$PATH
    eval "$(plenv init -)"
elif [ -d $HOME/perl5/perlbrew ]; then
    source $HOME/perl5/perlbrew/etc/bashrc
fi

# add histfile settings if there's no antigen
if [ -z $HISTFILE ]; then
    HISTFILE=~/.zsh_history
    HISTSIZE=1000
    SAVEHIST=1000
fi
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -e
zstyle :compinstall filename $HOME/.zshrc

autoload -Uz compinit
compinit

autoload -U select-word-style
select-word-style bash

function dta() {
    wget -O - $1 | grep -Eo 'i.4cdn.org/[^"]+' | uniq | grep -v 's.jpg' | xargs wget -c
}

# load any local configuration
if [ -f $HOME/.zshrc.local ]; then
    source $HOME/.zshrc.local
fi

typeset -U path

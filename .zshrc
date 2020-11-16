# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' use-compctl true
zstyle :compinstall filename ${ZDOTDIR:-$HOME}/.zshrc

autoload -Uz compinit
compinit
# End of lines added by compinstall

ALTERNATE_EDITOR=""
VISUAL="emacsclient"
alias ec="$VISUAL -c"
alias e=$VISUAL

LESS="-R"

export LESS ALTERNATE_EDITOR VISUAL

ttyctl -f

autoload -U select-word-style
select-word-style bash

# Set up zplug
[[ -d ~/.zplug ]] || {
    git clone https://github.com/zplug/zplug.git ~/.zplug
}

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions", defer:2

zplug "junegunn/fzf", hook-build:"./install --bin", use:"shell/*.zsh", defer:2

zplug "nojhan/liquidprompt"

zplug "lib/misc", from:oh-my-zsh
zplug "lib/termsupport", from:oh-my-zsh
zplug "lib/theme-and-appearance", from:oh-my-zsh

zplug "plugins/cargo", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/emacs", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/golang", from:oh-my-zsh
zplug "plugins/perl", from:oh-my-zsh
zplug "plugins/rust", from:oh-my-zsh

if [ -e ${ZDOTDIR:-$HOME}/.zshrc.local ]; then
    source ${ZDOTDIR:-$HOME}/.zshrc.local
fi

zplug "zplug/zplug", hook-build:"zplug --self-manage"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load

if zplug check junegunn/fzf; then
    FZF_DEFAULT_OPTS="--multi --reverse --inline-info"
    PATH=$HOME/.zplug/repos/junegunn/fzf/bin:$PATH
fi

if zplug check zsh-users/zsh-history-substring-search; then
    bindkey -M emacs '^P' history-substring-search-up
    bindkey -M emacs '^N' history-substring-search-down
fi

if zplug check zsh-users/zsh-autosuggestions; then
    bindkey '^M' autosuggest-execute
    bindkey '^G' autosuggest-clear
fi

zstyle ':completion:*' rehash true

setopt completealiases
setopt histignoredups sharehistory histignorespace

# function dta() {
#     wget -O - $1 | grep -Eo 'is.4chan.org/[^"]+' | uniq | grep -v 's.jpg' | xargs wget -c
# }

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

typeset -U PATH path

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

ttyctl -f

autoload -U select-word-style
select-word-style bash

# Set up zplug
[[ -d ~/.zplug ]] || {
    git clone https://github.com/zplug/zplug.git ~/.zplug
    source ~/.zplug/init.zsh
}

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

zplug "junegunn/fzf-bin", as:command, from:gh-r, use:"*linux*amd64*", rename-to:fzf
zplug "junegunn/fzf", as:command, use:"bin/fzf-tmux", rename-to:fzf-tmux
zplug "junegunn/fzf", use:"shell/*.zsh"

zplug "nojhan/liquidprompt"

zplug "lib/misc", from:oh-my-zsh, ignore:oh-my-zsh.sh
zplug "lib/termsupport", from:oh-my-zsh, ignore:oh-my-zsh.sh
zplug "lib/theme-and-appearance", from:oh-my-zsh, ignore:oh-my-zsh.sh

zplug "zplug/zplug"

if [ -e ${ZDOTDIR:-$HOME}/.zshrc.local ]; then
    source ${ZDOTDIR:-$HOME}/.zshrc.local
fi

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load

if zplug check junegunn/fzf-bin; then
    FZF_DEFAULT_OPTS="--multi --reverse --inline-info"
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
setopt histignoredups sharehistory

function dta() {
    wget -O - $1 | grep -Eo 'is.4chan.org/[^"]+' | uniq | grep -v 's.jpg' | xargs wget -c
}

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

typeset -U path

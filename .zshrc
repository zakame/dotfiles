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

autoload -U select-word-style
select-word-style bash

# Set up zplug
[[ -d ~/.zplug ]] || {
    curl -fLo ~/.zplug/zplug --create-dirs https://git.io/zplug
    source ~/.zplug/zplug && zplug update --self
}

source ~/.zplug/zplug

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zaw"

zplug "nojhan/liquidprompt", at:develop

zplug "b4b4r07/zplug"

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

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey '^M' autosuggest-execute
bindkey '^G' autosuggest-clear

bindkey '^R' zaw-history

zstyle :filter-select rotate-list yes
zstyle :filter-select case-insensitive yes
zstyle :filter-select hist-find-no-dups yes

zstyle ':completion:*' rehash true

setopt completealiases
setopt histignoredups sharehistory

function dta() {
    wget -O - $1 | grep -Eo 'i.4cdn.org/[^"]+' | uniq | grep -v 's.jpg' | xargs wget -c
}

alias ls="ls --color"

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

typeset -U path

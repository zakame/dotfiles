# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -e

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

zplug "lib/completion", from:oh-my-zsh
zplug "lib/misc", from:oh-my-zsh
zplug "lib/termsupport", from:oh-my-zsh
zplug "lib/theme-and-appearance", from:oh-my-zsh

zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/emacs", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/helm", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/perl", from:oh-my-zsh
zplug "plugins/ripgrep", from:oh-my-zsh

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

mkdir -p $ZSH/cache/completions
fpath=($ZSH/cache/completions $fpath)

if zplug check nojhan/liquidprompt; then
  if [[ "$LC_TERMINAL" == "iTerm2" || "$TERM" == "xterm-kitty" || "$TERM_PROGRAM" == "vscode" ]]; then
    source ~/.zplug/repos/nojhan/liquidprompt/themes/powerline/powerline.theme
    lp_theme powerline
  elif [[ "$INSIDE_EMACS" == "vterm" ]]; then
    lp_theme default
  else
    prompt_OFF
  fi
fi

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
    bindkey '^J' autosuggest-execute
    bindkey '^G' autosuggest-clear
fi

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

if [ -e $HOME/.emacs.d/emacs-vterm.zsh ]; then
  source $HOME/.emacs.d/emacs-vterm.zsh
fi

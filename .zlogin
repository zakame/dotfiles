CPAN="file:///home/ftp/pub/CPAN"
export PERL_CPANM_OPT="--mirror $CPAN --mirror-only"
alias cpan-outdated="cpan-outdated --mirror $CPAN"

[[ -f ~/.aliases ]] || touch ~/.aliases
source ~/.aliases
alias realias='$EDITOR ~/.aliases; source ~/.aliases'

if [ -e ${ZDOTDIR:-$HOME}/.zlogin.local ]; then
    source ${ZDOTDIR:-$HOME}/.zlogin.local
fi

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

typeset -U PATH path

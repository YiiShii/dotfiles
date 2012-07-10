#
# Basic configuration
#

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch
unsetopt notify
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit

#
# Theme configuration
# Look in ~/.oh-my-zsh/themes/
#

HOST=`hostname -s`
case $HOST {
    simba|banksy|aiden-air) export ZSH_THEME="nanotech" ;;
    crunchy|aiden-u10) export ZSH_THEME="Soliah" ;;
    anton|util[0-9]*) export ZSH_THEME="candy" ;;
    *) export ZSH_THEME="daveverwer" ;;
    # using: daveverwer candy Soliah kennethreitz random
}

#
# Oh-my-zsh configuration
#

export ZSH=$HOME/.oh-my-zsh
export DISABLE_AUTO_UPDATE="true"
plugins=(git brew gem knife rails ruby zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh


# Load rvm/rbenv depending on which is installed
if [ -s $HOME/.rvm/scripts/rvm ] ; then
    # This line is to fix some RVM/ZSH interactions for determining the current path
    unsetopt auto_name_dirs
    source $HOME/.rvm/scripts/rvm
else
    if which rbenv > /dev/null; then
        eval "$(rbenv init -)"
    fi
fi

# Sane, without rbenv/rvm
# export PATH=$HOME/src/scripts:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

case ${TERM} in
  screen-256color) TERM=xterm-color
  ;;
esac

export EDITOR=vim

test -r ~/.zshrc.$HOST && . ~/.zshrc.$HOST
test -r ~/.zshrc.local && . ~/.zshrc.local

export NODE_PATH=/usr/local/lib/node

#
# Load extra functionality
#

if [ -d ~/.dotfiles ] ; then
    export DOTFILES=~/.dotfiles
fi

if [ $DOTFILES ] ; then
    for f in $DOTFILES/shell/* ; do
        . $f
    done
fi

#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd)
XDG_CONFIG_HOME="$HOME/.config"
XDG_CONFIG_MODULES=$(find $DOTFILES_DIR/.config -maxdepth 1 -mindepth 1 -type d)

cd $DIR

_symlink() {
    local source=$1
    local dest=$2

    echo "SYMLINKING $dest => $source"

    if [ -f $dest ] && [ ! -L $dest ] ; then
        mv $dest $dest.backup.$(date +"%F-%T")
        ln -s $source $dest
    fi
    if [ -L $dest ] ; then
        if [ "`readlink -f $dest`" != "$source" ] ; then
            mv $dest $dest.backup.$(date +"%F-%T")
            ln -s $source $dest
        fi
    else
        ln -s $source $dest
    fi
}

_symlink $DOTFILES_DIR/.bashrc $HOME/.bashrc
_symlink $DOTFILES_DIR/.inputrc $HOME/.inputrc


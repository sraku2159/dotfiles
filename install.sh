#!/bin/bash

set -uex

cd $(dirname ${BASH_SOURCE:-$0})

function backup_originals() {
    if [ ! -d "$HOME"/.backups ]; then
        mkdir "$HOME"/.backups
    fi
    
    for f in .??*; do
        [ "$f" = ".git" ] && continue
        mv ~/"$f" ~/.backups
    done
}

function create_link() {
    for f in .??*; do
        [ "$f" = ".git" ] && continue
        ln -snvf $PWD/"$f" ~/
    done
}

backup_originals();
create_link();

git config --global include.path "~/.gitconfig_shared"
echo "\033[38;5;40m done \033[0m"

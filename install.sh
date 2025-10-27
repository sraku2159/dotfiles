#!/bin/bash

help() {
  echo 'without option: install minimum'
  echo '-h: display usage'
  echo '-a: install all'
  echo '--with-mise: install minimum with mise'
  echo '--with-wezterm: install minimum with wezterm'
}

if [ "$1" = '-h' ]; then
  help
  exit 0
fi

set -ex

cd $(dirname ${BASH_SOURCE:-$0})

create_link() {
  for f in .??*; do
    [ "$f" = ".git" ] && continue
    ln -snvf $PWD/"$f" ~/
  done
}

create_link

# Configure git to include additional configs
git config --global include.path "~/.config/git/.gitconfig_shared"
git config --global include.path "~/.config/git/.gitconfig_delta"

echo -e "\033[38;5;40m done \033[0m"

# install vim jetpack
taget="$HOME/.vim/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim"
if [[ ! -e "$taget" ]]; then
  curl -fLo "$taget" --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim
fi

cd

curl -o .git-completion.sh \
  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o .git-prompt.sh \
  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

# install mise

if [ "$1" = '--with-mise' -o "$1" = '-a' ]; then
  curl https://mise.run | sh
fi

# install wezterm
if [ "$1" = '--with-wezterm' -o "$1" = '-a' ]; then
  brew install --cask wezterm
fi

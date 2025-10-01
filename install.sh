#!/bin/bash

set -uex

cd $(dirname ${BASH_SOURCE:-$0})

function backup_originals() {
    if [ ! -d "$HOME"/.backups ]; then
        mkdir "$HOME"/.backups
    fi
    
    for f in .??*; do
        [ ! -e "$HOME/$(basename $f)" -o "$f" = ".git" ] && continue
        mv ~/"$f" ~/.backups
    done
}

function create_link() {
    for f in .??*; do
        [ "$f" = ".git" ] && continue
        ln -snvf $PWD/"$f" ~/
    done
}

backup_originals
create_link

git config --global include.path "~/.gitconfig_shared"
echo -e "\033[38;5;40m done \033[0m"

# install vim jetpack
taget="$HOME/.vim/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim"
if [[ ! -e $taget ]]; then
  curl -fLo $taget --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim
fi

cd

curl -o .git-completion.sh \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o .git-prompt.sh \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

# install mise
curl https://mise.run | sh


# install tools with mise
if command -v mise &> /dev/null; then
  echo "✅ mise is installed"
  echo "Version: $(mise --version)"
  echo "Path: $(which mise)"
else
  echo "❌ mise is not installed"
  exit 1
fi

mise use -g rust

# install wezterm
curl https://sh.rustup.rs -sSf | sh -s
curl -LO https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203-110809-5046fc22-src.tar.gz
tar -xzf wezterm-20240203-110809-5046fc22-src.tar.gz
cd wezterm-20240203-110809-5046fc22
./get-deps
cargo build --release
cargo run --release --bin wezterm -- start


# install delta
cargo install git-delta

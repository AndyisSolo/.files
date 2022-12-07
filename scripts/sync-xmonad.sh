#!/bin/bash

[ ! -d $HOME/.local/bin ] && mkdir -p $HOME/.local/bin
[ ! -d $HOME/.local/share ] && mkdir -p $HOME/.local/share
[ ! -d $HOME/.config ] && mkdir -p $HOME/.config
[ ! -d $HOME/.cache ]  && mkdir -p $HOME/.cache; touch $HOME/.cache/.zsh_history

function syncConfig {
    srcPath=$1
    destPath=$2

    dotfiles=()

    while IFS= read -r -d $'\0'; do
        dotfiles+=($REPLY)
    done < <(find $srcPath -maxdepth 1 -print0)

    for src in "${dotfiles[@]}"; do
        if [ $srcPath == $src ]; then continue; fi
        dest=${src/\/dotfiles\///}
        rm -rf $dest
        name=$(basename $src)
        printf "syncing $src to $dest \n"
        ln -sf $src $destPath/$name
    done

}

syncConfig ~/dotfiles/.config ~/.config
syncConfig ~/dotfiles/.local/bin ~/.local/bin

# Sync dotfile from root directory
exclude=("dotfiles-install.sh" "dotfiles-sync.sh" "dotfiles-software.sh")
dotfiles=()
while IFS= read -r -d $'\0'; do
    dotfiles+=($REPLY)
done < <(find $HOME/dotfiles -maxdepth 1 -type f -print0)

for src in "${dotfiles[@]}"; do
    if [[ "${exclude[*]}" =~ $(basename $src) ]]; then continue; fi
    dest=${src/\/dotfiles\///}
    printf "syncing $src to $dest \n"
    ln -sf $src $dest
done

# install plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' >/dev/null 2>&1

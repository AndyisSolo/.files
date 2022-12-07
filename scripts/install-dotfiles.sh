#!/bin/bash
cd $HOME

# -------------------------------------
# Download and install dotfiles
# -------------------------------------
mkdir $HOME/.cache 2>/dev/null && touch $HOME/.cache/.zsh_history

rm -rf $HOME/dotfiles
dotfiles_origin=https://github.com/asolopovas/dotfiles.git
git clone $dotfiles_origin

git clone https://github.com/oh-my-fish/oh-my-fish
pushd oh-my-fish
bin/install --offline
popd
rm -rf oh-my-fish

source $HOME/dotfiles/dotfiles-sync.sh

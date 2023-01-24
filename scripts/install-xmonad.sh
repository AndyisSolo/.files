#!/bin/bash

pushd ~/.config/xmonad

sudo apt install g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg netbase
sudo apt install git libx11-dev libxft-dev libxinerama-dev libxrandr-dev libxss-dev haskell-stack -y

sudo snap install go --classic

# if xmonad folder does not exist
if  [ ! -d $HOME/.config/xmonad ]; then
    mkdir -p $HOME/.config/xmonad
    git clone --branch v0.17.1 https://github.com/xmonad/xmonad
fi
if  [ ! -d $HOME/.config/xmonad-contrib ]; then
    mkdir -p $HOME/.config/xmonad-contrib
    git clone --branch v0.17.1 https://github.com/xmonad/xmonad-contrib
fi
stack build

# if haskell installed
    if ! command -v stack &> /dev/null
    then
        curl -sSL https://get.haskellstack.org/ | sh
        echo "stack could not be found"
        exit
    fi

sudo snap install go --classic
git clone https://github.com/xintron/xmonad-log.git $GOPATH/src/github.com/xintron/xmonad-log


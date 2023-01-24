#!/bin/bash

pushd ~/.config/xmonad

sudo apt install g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg netbase
sudo apt install git libx11-dev libxft-dev libxinerama-dev libxrandr-dev libxss-dev haskell-stack -y

sudo snap install go --classic

# if xmonad folder does not exist
if [ ! -d $HOME/.config/xmonad ]; then
    mkdir -p $HOME/.config/xmonad
    git clone --branch v0.17.1 https://github.com/xmonad/xmonad
fi
if [ ! -d $HOME/.config/xmonad-contrib ]; then
    mkdir -p $HOME/.config/xmonad-contrib
    git clone --branch v0.17.1 https://github.com/xmonad/xmonad-contrib
fi

if [ ! -d $HOME/.config/xmonad-dbus ]; then
    mkdir -p $HOME/.config/xmonad-dbus
    git clone https://github.com/troydm/xmonad-dbus.git
fi

# if haskell installed
if ! command -v stack &>/dev/null; then
    curl -sSL https://get.haskellstack.org/ | sh
fi

stack install

sudo snap install go --classic

xmonadLog="$GOPATH/src/github.com/xintron/xmonad-log"
if [ ! -d $xmonadLog ]; then
    mkdir -p $xmonadLog
    pushd $xmonadLog
    $GOPATH/src/github.com/xintron/xmonad-log
    git clone https://github.com/xintron/xmonad-log.git $xmonadLog
    go get github.com/godbus/dbus
    go mod init
    go build
    go install
fi

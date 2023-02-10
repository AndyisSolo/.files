#!/bin/bash

XMONAD_ORIGIN=$HOME/dotfiles/.config/xmonad
XMONAD_DIR=$HOME/.config/xmonad

ln -sf $XMONAD_ORIGIN $XMONAD_DIR


sudo apt install g++ gcc libc6-dev libffi-dev libgmp-dev \
                 make xz-utils zlib1g-dev git gnupg netbase \
                 git libx11-dev libxft-dev libxinerama-dev \
                 libxrandr-dev libxss-dev haskell-stack -y

sudo snap install go --classic

pushd $XMONAD_DIR

if [ ! -d ./xmonad ]; then
    git clone --branch v0.17.1 https://github.com/xmonad/xmonad
fi
if [ ! -d ./xmonad-contrib ]; then
    git clone --branch v0.17.1 https://github.com/xmonad/xmonad-contrib
fi

xmonadDBusSrc=$XMONAD_DIR/xmonad-dbus
if [ ! -d ./xmonad-dbus ]; then
    git clone https://github.com/troydm/xmonad-dbus.git
fi

# if haskell installed
if ! command -v stack &>/dev/null; then
    curl -sSL https://get.haskellstack.org/ | sh
fi

stack install

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

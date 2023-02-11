#!/bin/bash

XMONAD_ORIGIN=$HOME/dotfiles/.config/xmonad/

ln -sf $XMONAD_ORIGIN $XDG_CONFIG_HOME

sudo apt install g++ gcc libc6-dev libffi-dev libgmp-dev \
    make xz-utils zlib1g-dev git gnupg netbase \
    git libx11-dev libxft-dev libxinerama-dev \
    libxrandr-dev libxss-dev haskell-stack polybar -y

sudo apt install curl cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 -y

sudo snap install go --classic

pushd $XDG_CONFIG_HOME/xmonad

# Cargo Install
curl https://sh.rustup.rs -sSf | sh -s -- -y
# Alacritty
cargo install alacritty

if [ ! -d $XMONAD_DIR/xmonad ]; then
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

sudo tee /usr/share/xsessions/xmonad.desktop >/dev/null <<EOT
[Desktop Entry]
Name=Xmonad
Comment=Lightweight Tiling Window Manager
Exec=$HOME/.cache/xmonad/xmonad-x86_64-linux
Type=XSession
DesktopNames=Xmonad
EOT



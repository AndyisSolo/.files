#!/bin/bash
VER="${VER:-16.18.0}"

if [[ $NVM = true ]] || [[ ! -d $HOME/.nvm ]] || [[ $FORCE = true ]]; then
    NVM_NODEJS_ORG_MIRROR=https://unofficial-builds.nodejs.org/download/release
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    echo 'nvm_get_arch() { nvm_echo "x64-musl"; }' | tee -a $HOME/.zshrc $HOME/.bashrc
    source $HOME/.nvm/nvm.sh
    source $HOME/.bashrc
    nvm install $VER
    npm install -g yarn svgo
fi

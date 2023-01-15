# sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/ttymaps.kmap 2>/dev/null
[ ! -d $XMONAD_DATA_HOME ] && mkdir $XMONAD_DATA_HOME

export LC_ALL="en_GB.UTF-8"
export _JAVA_AWT_WM_NONREPARENTING=1
export SUDO_ASKPASS="$HOME/dotfiles/helpers/tools/dmenupass"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export QT_QPA_PLATFORMTHEME="qt5ct"

# Applications
export FILEMANAGER="pcmanfm"
export TERMINAL="alacrity"

# Clean-Up
export LESSHISTFILE="-"
export LESS=-R
export SUDO_ASKPASS="$HOME/.local/bin/helpers/tools/dmenupass"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/docker"
export GEM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/gem"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/gem"
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export GOPATH="$HOME/.go"
export GOBIN="$HOME/.go/bin"
export GO111MODULE=on
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/.gtkrc-2.0"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export KDEHOME="${XDG_CONFIG_HOME:-$HOME/.config}/kde"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export WEECHAT_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/weechat"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export XMONAD_CACHE_HOME="${XDG_CACHE_HOME:-$H/opt/phpstorm/bin/phpstorm.shOME/.cache}/xmonad"
export XMONAD_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/xmonad"
export XMONAD_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/xmonad"
export HOSTALIASES=~/.hosts

FZFARGS="\
    -E \"*npm*\" \
    -E \"*lib*\" \
    -E \"*.go/pkg/*\" \
    -E \"*vscode*\" \
    -E .git \
    -E .docker \
    -E .nvm \
    -E .local \
    -E .yarn \
    -E .cache \
    -E cache \
    -E Cache \
    -E Code \
    -E node_modules \
    -E Steam \
    -E skype \
    -E vendor \
    -E npm \
    -E chrome \
    -E gem \
    -E fish \
    -E python \
    -E mozilla \
    -E cargo \
    -E log
"
# FZF Settings
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

export FZF_CTRL_T_COMMAND="fd -t f -H $FZFARGS ."
export FZF_ALT_C_COMMAND="fd -t d -H $FZFARGS ."

# Docker Settings
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Remove hostname from bash
export PS1="\W \$"

PATH=/usr/local/go/bin:$PATH
PATH=~/.config/composer/vendor/bin:$PATH
PATH=~/.cargo/bin/$PATH
PATH=~/.local/bin:$PATH
PATH=~/.local/bin/helpers:$PATH
PATH=~/.local/bin/helpers/apps:$PATH
PATH=~/.local/bin/helpers/statusbar:$PATH
PATH=~/.local/bin/helpers/system:$PATH
PATH=~/.local/bin/helpers/tools:$PATH
PATH=~/.local/bin/helpers/web:$PATH
PATH=~/.local/share/gem/bin:$PATH
PATH=~/.deno/bin:$PATH
PATH=~/.nvm/bin:$PATH
PATH=~/.yarn/bin:$PATH
PATH=~/go/bin:$PATH



# Load NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
. "$HOME/.cargo/env"



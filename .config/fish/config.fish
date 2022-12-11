#!/bin/fish

# Start Gnome Keyring
if set -q DESKTOP_SESSION
    set -x (gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg | string split "=")
end

# Fish ==================
fish_default_key_bindings
set fish_greeting
set fish_color_search_match --background=blue
set -U fish_prompt_pwd_dir_length 0

# Env Variables =========
set -x TERMINAL alacritty
set -x EDITOR nvim
set -x GOPATH $HOME/go
set -x GOBIN $HOME/go/bin
set -x GO111MODULE on

# Path Variables =========
set -x PATH $HOME/go/bin $PATH

function add2path
    if test -d $HOME/$argv; and not contains $HOME/$argv $PATH
        set PATH $HOME/$argv $PATH
    end
end

add2path go/bin
add2path .local/bin
add2path .local/bin/helpers
add2path .local/bin/helpers/apps
add2path .local/bin/helpers/statusbar
add2path .local/bin/helpers/system
add2path .local/bin/helpers/tools
add2path .local/bin/helpers/web
add2path .local/share/gem/bin
add2path .yarn/bin
add2path .deno/bin
add2path .nvm/bin
add2path .cargo/bin
add2path .config/composer/vendor/bin

# Aliases
source $HOME/.config/.aliasrc
if type -qs bass
    bass source $HOME/.nvm/nvm.sh
end

# pnpm
set -gx PNPM_HOME "/home/lyntouch/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

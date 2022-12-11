#!/bin/bash
OS=$(awk '/^ID=/' /etc/os-release | sed -e 's/ID=//' -e 's/"//g' | tr '[:upper:]' '[:lower:]')
GREEN='\033[0;32m'
NC='\033[0m'
NODEVER="18.12.1"
SILENT=false
if [ "$1" = "silent" ]; then
    SILENT=true
fi

function printGreen() {
    printf "${GREEN}------------------------------------------${NC}\n"
    printf "${GREEN}$1${NC}\n"
    printf "${GREEN}------------------------------------------${NC}\n"
}

PI=$HOME/dotfiles/helpers/system/p

DOTFILES="${DOTFILES:-true}"
FISH="${FISH:-false}"
FDFIND="${FDFIND:-false}"
FZF="${FZF:-false}"
NVM="${NVM:-false}"
NVIM="${NVIM:-false}"
ZSH="${ZSH:-false}"
OHMYFISH="${OHMYFISH:-false}"
OHMYBASH="${OHMYBASH:-false}"
OHMYZSH="${OHMYZSH:-false}"
FORCE="${FORCE:-false}"

if [ "$SILENT" = false ]; then
    CHOICES=$(
        whiptail --title "Dotfiles" --checklist --separate-output "Choose:" 16 60 9 \
            "DOTFILES" "Dotfiles   " ON \
            "FISH" "Unix shell   " ON \
            "FDFIND" "Unix find replacement   " ON \
            "FZF" "Fuzzy Find   " ON \
            "NVM" "NVM   " ON \
            "NVIM" "Neovim modern Vim   " ON \
            "OHMYFISH" "The Fishshell Framework   " ON \
            "ZSH" "Z-Shell Shell  " OFF \
            "OHMYBASH" "Oh My Bash framework  " OFF \
            "OHMYZSH" "Oh My Zsh framework  " OFF \
            "FORCE" "Force install all modules   " OFF \
            3>&1 1>&2 2>&3
    )

    if [ -z "$CHOICES" ]; then
        printGreen "No options were selected (user hit Cancel or unselected all options)"
        exit
    else
        for CHOICE in $CHOICES; do
            case "$CHOICE" in
            "DOTFILES")
                DOTFILES=true
                ;;
            "FISH")
                FISH=true
                ;;
            "FDFIND")
                FDFIND=true
                ;;
            "FZF")
                FZF=true
                ;;
            "NVM")
                NVM=true
                ;;
            "NVIM")
                NVIM=true
                DOTFILES+=(".config/nvim")
                ;;
            "ZSH")
                ZSH=true
                DOTFILES+=(".config/.zshrc")
                ;;
            "OHMYFISH")
                OHMYFISH=true
                ;;
            "OHMYBASH")
                OHMYBASH=true
                ;;
            "OHMYZSH")
                OHMYZSH=true
                ;;
            "FORCE")
                FORCE=true
                ;;
            esac
        done
    fi
fi

pushd $HOME >/dev/null

if [ "$DOTFILES" = true ]; then
    URL="git@github.com:asolopovas/dotfiles.git"
    if [ ! -f "$HOME/.ssh/id_rsa" ]; then
        URL="https://github.com/asolopovas/dotfiles.git"
    fi

    if [ "$FORCE" = true ]; then
        rm -rf $HOME/dotfiles
    fi

    if [ ! -d "$HOME/dotfiles" ]; then
        printGreen "DOWNLOADING DOTFILES..."
        git clone $URL $HOME/dotfiles >/dev/null
    fi
fi

printGreen "CREATING DEFAULT DIRS ..."
DEFAULT_DIRS=(
    ".local/bin"
    ".local/share"
    ".local/.config"
    ".local/.cache"
)
for DIR in "${DEFAULT_DIRS[@]}"; do
    if [ ! -d "$HOME/$DIR" ]; then
        printf "Creating $HOME/$DIR ...\n"
        mkdir -p "$HOME/$DIR"
    fi
done
touch $HOME/.cache/.zsh_history


printGreen "CREATING SYMLINKS ..."
CONFDIRS=(
    ".config/.func"
    ".config/.aliasrc"
    ".config/inputrc"
    ".config/fish"
    ".bashrc"
)
if [ "$NVIM" = true ]; then
    CONFDIRS+=(".config/nvim")
fi
if [ "$ZSH" = true ]; then
    CONFDIRS+=(".config/.zshrc")
fi
mkdir -p $HOME/.local/bin
echo "$HOME/dotfiles/helpers $HOME/.local/bin/helpers" | awk '{ printf "%-40s => %-40s\n", $1, $2}'
ln -sf $HOME/dotfiles/helpers $HOME/.local/bin
for src in "${CONFDIRS[@]}"; do
    echo "$HOME/dotfiles/$src $HOME/$src" | awk '{ printf "%-40s => %-40s\n", $1, $2}'
    if [ -d "$HOME/$src" ]; then
        rm -rf $HOME/$src
    fi
    ln -sf $HOME/dotfiles/$src $HOME/$src
done

if [ "$FISH" = true ] && ! command -v fish &>/dev/null; then
    printGreen "INSTALLING FISH..."
    if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
        sudo apt-add-repository -y ppa:fish-shell/release-3 >/dev/null 2>&1
        sudo apt update -qq -y >/dev/null >/dev/null 2>&1
    fi
    $PI i fish >/dev/null
fi

if [ "$NVM" = true ]; then
    if [ "$FORCE" = true ]; then
        rm -rf $HOME/.nvm
    fi

    if [ ! -d "$HOME/.nvm" ]; then
        printGreen "INSTALLING NVM ..."
        if [ "$OS" = "alpine" ]; then
            NVM_NODEJS_ORG_MIRROR=https://unofficial-builds.nodejs.org/download/release
            echo 'nvm_get_arch() { nvm_echo "x64-musl"; }' | tee -a $HOME/.bashrc
        fi
        curl -sO https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh
        chmod +x install.sh >/dev/null
        ./install.sh >/dev/null 2>&1
        rm -rf install.sh >/dev/null
        source $HOME/.nvm/nvm.sh >/dev/null
        source $HOME/.bashrc >/dev/null
        nvm install $NODEVER >/dev/null
        npm install -g yarn >/dev/null
    fi
fi

if [ "$OHMYFISH" = true ] && command -v fish &>/dev/null; then
    if [ "$FORCE" = true ]; then
        rm -rf $HOME/.local/share/omf
        rm -rf $HOME/.config/omf
    fi

    if [ ! -d "$HOME/.local/share/omf" ]; then
        printGreen "INSTALLING OH-MY-FISH..."
        curl -sO https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install
        fish install --noninteractive --path=~/.local/share/omf --config=~/.config/omf >/dev/null
        fish -c "omf install bass"
        fish -c "omf install agnoster"
        fish -c "omf theme agnoster"
        rm -rf install
    fi
fi

if [ "$FDFIND" = true ] && ! command -v fd &>/dev/null && ([ "$OS" = "ubuntu" ] || [ ""$OS"" = "debian" ]); then
    printGreen "INSTALLING FDFIND..."
    curl -fsSLO https://github.com/sharkdp/fd/releases/download/v8.5.3/fd-musl_8.5.3_amd64.deb >/dev/null
    sudo dpkg -i fd-musl_8.5.3_amd64.deb
    rm -rf fd-musl_8.5.3_amd64.deb
fi

if [ "$FZF" = true ]; then
    if [ "$FORCE" = true ]; then
        rm -f $HOME/.local/bin/fzf
    fi

    if [ ! -f "$HOME/.local/bin/fzf" ]; then
        printGreen "INSTALLING FZF..."
        curl -fsSLO https://github.com/junegunn/fzf/releases/download/0.35.1/fzf-0.35.1-linux_amd64.tar.gz
        tar -xf fzf-0.35.1-linux_amd64.tar.gz
        mv fzf $HOME/.local/bin
        rm -f fzf-0.35.1-linux_amd64.tar.gz
    fi
fi

if [ "$NVIM" = true ]; then
    if [ "$OS" = "ubuntu" ] || [ ""$OS"" = "debian" ]; then
        printGreen "INSTALLING NVIM..."
        sudo add-apt-repository -y ppa:neovim-ppa/stable >/dev/null
        sudo apt update -qq -y >/dev/null
        $PI r vim >/dev/null
    fi

    if [ ! "$OS" = "alpine" ]; then
        $PI i neovim >/dev/null
    fi

    if [ "$FORCE" = true ]; then
        rm -rf $HOME/.local/share/nvim/site/autoload
    fi

    if [ ! -d "$HOME/.local/share/nvim/site/autoload/" ]; then
        printGreen "INSTALLING NVIM PLUG..."
        curl -sfLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        bash -c "nvim +silent +PlugInstall +qall"
    fi
fi

if [ "$OHMYBASH" = true ]; then
    if [ "$FORCE" = true ]; then
        rm -rf $HOME/.local/share/ohmybash
    fi

    if [ ! -d "$HOME/.local/share/ohmybash" ]; then
        printGreen "INSTALLING OH-MY-BASH..."
        git clone https://github.com/ohmybash/oh-my-bash.git $HOME/.local/share/ohmybash
    fi
fi

if [ "$ZSH" = true ]; then
    printGreen "INSTALLING ZSH..."
    $PI i zsh >/dev/null
fi

if [ "$OHMYZSH" = true ]; then
    if [ "$FORCE" = true ]; then
        rm -rf $HOME/.oh-my-zsh
    fi

    if [ ! -d "$HOME/.local/share/ohmyzsh" ]; then
        printGreen "INSTALLING OH-MY-ZSH..."
        ZSH="$HOME/.local/share/ohmyzsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        ln -sf $HOME/dotfiles/.config/zsh $HOME/.config/zsh
        ln -sf $HOME/dotfiles/.config/zsh/.zshrc $HOME/.zshrc
    fi
fi

if [ "$FISH" = true ] && [ "$SHELL" != "/usr/bin/fish" ] && [ "$SILENT" = false ]; then
    if [ "$SILENT" = false ]; then
        echo "Do you want to change default shell to fish? [y/n]"
        read -r answer
    else
        answer="y"
    fi

    if [ "$answer" = "y" ]; then
        sudo chsh -s /usr/bin/fish >/dev/null
    fi
fi

popd >/dev/null

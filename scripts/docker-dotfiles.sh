#!/bin/bash
[[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
[[ ! -d $HOME/.local/share ]] && mkdir -p $HOME/.local/share
[[ ! -d $HOME/.config ]] && mkdir -p $HOME/.config
[[ ! -d $HOME/.cache ]] && mkdir -p $HOME/.cache

touch $HOME/.cache/.zsh_history

# Dotfiles Sync List
dotfiles=(
    ".config/fish"
    ".config/nvim"
    ".config/.func"
    ".config/.aliasrc"
    ".config/inputrc"
    ".bashrc"
)

for src in "${dotfiles[@]}"; do
    if [[ ! -f $HOME/$src ]] && [[ ! -d $HOME/$src ]] || [[ $FORCE = true ]]; then
        echo "~/dotfiles/$src ~/$src" | awk '{ printf "%-28s=> %-40s\n", $1, $2}'
        rm -rf $HOME/$src
        ln -s $HOME/dotfiles/$src $HOME/$src
    fi
done

# Neovim Autoload Script
if [[ $NVIMAUTOLOAD = true ]] || [[ ! -d $HOME/.local/share/nvim/site/autoload/ ]] || [[ $FORCE = true ]]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    pip install pynvim
    nvim +silent +PlugInstall +qall
fi

# oh-my-bash
if [[ $OHMYBASH = true ]] || [[ ! -d $HOME/.local/share/ohmybash ]] || [[ $FORCE = true ]]; then
    rm -rf $HOME/.local/share/ohmybash
    git clone https://github.com/ohmybash/oh-my-bash.git $HOME/.local/share/ohmybash
fi

# oh-my-zsh
if which zsh >/dev/null && [[ ! -d $HOME/.local/share/ohmyzsh ]] || [[ $OHMYZSH = true ]] || [[ $FORCE = true ]]; then
    ZSH="$HOME/.local/share/ohmyzsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    ln -sf $HOME/dotfiles/.config/zsh $HOME/.config/zsh
    ln -sf $HOME/dotfiles/.config/zsh/.zshrc $HOME/.zshrc
fi

# oh-my-fish
if [[ $OHMYFISH = true ]] || [[ ! -d $HOME/.local/share/omf ]] || [[ $FORCE = true ]]; then
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > $HOME/install
    fish $HOME/install --noninteractive --path=$HOME/.local/share/omf --config=$HOME/.config/omf
    fish -c "omf install bass"
    fish -c "omf install agnoster"
    fish -c "omf theme agnoster"
    rm -rf $HOME/install
fi


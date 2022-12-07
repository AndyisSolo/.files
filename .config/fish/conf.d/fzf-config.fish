set -q FZF_TMUX_HEIGHT; or set -U FZF_TMUX_HEIGHT "40%"
set -q FZF_DEFAULT_OPTS; or set -U FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT"
set -q FZF_LEGACY_KEYBINDINGS; or set -U FZF_LEGACY_KEYBINDINGS 1
set -q FZF_DISABLE_KEYBINDINGS; or set -U FZF_DISABLE_KEYBINDINGS 0
set -q FZF_PREVIEW_FILE_CMD; or set -U FZF_PREVIEW_FILE_CMD "head -n 15"
set -q FZF_PREVIEW_DIR_CMD; or set -U FZF_PREVIEW_DIR_CMD ls

set FZFARGS \
    -E .docker \
    -E node_modules \
    -E Steam \
    -E skype \
    -E vendor \
    -E .nvm \
    -E .local \
    -E .yarn \
    -E .cache \
    -E '"*npm*"' \
    -E '"*lib*"' \
    -E '"*.go/pkg/*"' \
    -E '"*vscode*"' \
    -E Code \
    -E chrome \
    -E Cache \
    -E cache \
    -E gem \
    -E fish \
    -E python \
    -E .git \
    -E mozilla \
    -E cargo \
    -E log

set -U FZF_CD_WITH_HIDDEN_COMMAND "fd -H -t d $FZFARGS ."
set -U FZF_CD_COMMAND "fd -H -t d $FZFARGS  ."

#!/bin/sh

# vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:



set -Ceu

cd "$(dirname $0)"
DIRECTORY="$(pwd)"

if [ ! -d "$HOME/.config/fish" ]; then
    mkdir -p "$HOME/.config/fish"
fi
if [ ! -d "$HOME/.local/share/nvim/site" ]; then
    mkdir -p "$HOME/.local/share/nvim/site"
fi
if [ ! -d "$HOME/.config/wezterm" ]; then
    mkdir -p "$HOME/.config/wezterm"
fi

for FILE in $(find "$DIRECTORY/dotfiles" -maxdepth 1 | grep -Ev "^$DIRECTORY/dotfiles$")
do
    BASENAME="$(basename "$FILE")"
    ln -ins  "$FILE" "$HOME/$BASENAME"
done

# fish
ln -ins "$HOME/.fish/config.fish" "$HOME/.config/fish"
ln -ins "$HOME/.fish/functions" "$HOME/.config/fish"

# neovim
ln -ins "$HOME/.vim" "$HOME/.config/nvim"
ln -ins "$HOME/.vim/pack" "$HOME/.local/share/nvim/site/pack"

# vim
ln -ins "$HOME/.vim/init.vim" "$HOME/.vimrc"

# wezterm
ln -ins "$HOME/.wezterm/wezterm.lua" "$HOME/.config/wezterm"



# Local variables:
# tab-width: 4
# c-basic-offset: 4
# c-hanging-comment-ender-p: nil
# End:


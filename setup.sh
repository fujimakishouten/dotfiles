#!/bin/sh

# vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:



set -Ceu

cd `dirname $0`
DIRECTORY=`pwd`

for FILE in `find $DIRECTORY/dotfiles -maxdepth 1 ! -path dotfiles`
do
    BASENAME=`basename $FILE`
    ln -ins  $FILE $HOME/$BASENAME
done

if [ ! -d ~/.config ]; then
    mkdir $HOME/.config
fi
if [ ! -d ~/.config/nvim ]; then
    ln -ins $HOME/.vim $HOME/.config/nvim
    ln -ins $HOME/.vimrc $HOME/.config/nvim/init.vim
fi
if [ ! -d ~/.config/fish ]; then
    mkdir -p $HOME/.config/fish
    ln -ins $HOME/.fish/config.fish $HOME/.config/fish
    ln -ins $HOME/.fish/functions $HOME/.config/fish
fi


# Local variables:
# tab-width: 4
# c-basic-offset: 4
# c-hanging-comment-ender-p: nil
# End:


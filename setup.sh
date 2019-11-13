#!/bin/sh

# vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:



set -Ceu

cd `dirname $0`
DIRECTORY=`pwd`

if [ ! -d $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim
fi
if [ ! -d $HOME/.config/fish ]; then
    mkdir -p $HOME/.config/fish
fi

for FILE in `find $DIRECTORY/dotfiles -maxdepth 1 | egrep -v ^"$DIRECTORY"/dotfiles$`
do
    BASENAME=`basename $FILE`
    ln -ins  $FILE $HOME/$BASENAME
done

# neovim
ln -ins $HOME/.vim $HOME/.config/nvim
ln -ins $HOME/.vimrc $HOME/.config/nvim/init.vim

# fish
ln -ins $HOME/.fish/config.fish $HOME/.config/fish
ln -ins $HOME/.fish/functions $HOME/.config/fish



# Local variables:
# tab-width: 4
# c-basic-offset: 4
# c-hanging-comment-ender-p: nil
# End:


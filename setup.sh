#!/bin/sh

# vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:



set -Ceu

cd `dirname $0`
DIRECTORY=`pwd`

for FILE in `find $DIRECTORY/dotfiles -maxdepth 1 ! -path dotfiles`
do
    BASENAME=`basename $FILE`
    ln -i -s  $FILE $HOME/$BASENAME
done

if [ -d ~/.config ]; then
    ln -i -s $HOME/.vim $HOME/.config/nvim
fi
if [ -d ~/.config ]; then
    ln -i -s $HOME/.fish $HOME/.config/fish
fi



# Local variables:
# tab-width: 4
# c-basic-offset: 4
# c-hanging-comment-ender-p: nil
# End:


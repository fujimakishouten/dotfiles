#!/bin/sh

# vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4:



set -Ceu

cd `dirname $0`
DIRECTORY=`pwd`

for FILE in `find $DIRECTORY/dotfiles -maxdepth 1 ! -path dotfiles`
do
    BASENAME=`basename $FILE`
    ln --interactive --no-dereference --symbol  $FILE $HOME/$BASENAME
done

if [ -d ~/.config ]; then
    ln --interactive --no-dereference --symbol $HOME/.vim $HOME/.config/nvim
fi



# Local variables:
# tab-width: 4
# c-basic-offset: 4
# c-hanging-comment-ender-p: nil
# End:


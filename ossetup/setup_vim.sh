#!/bin/bash
# Program:
#   Setup configuration for vim
# History:
#   2018/10/27  KibaAmor     First release

### Set PATH
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

### Config
SCRIPT_PATH=$(dirname ${BASH_SOURCE[0]})
SRC_DIR=$SCRIPT_PATH/config
DST_DIR=~

#######################################################################

# Exit on error
set -ex


# Back old config
[[ -f $DST_DIR/.vimrc.bk ]] && rm -f $DST_DIR/.vimrc
[[ -f $DST_DIR/.vimrc ]] && mv $DST_DIR/.vimrc $DST_DIR/.vimrc.bk

[[ -d $DST_DIR/.vim.bk ]] && rm -rf $DST_DIR/.vim
[[ -d $DST_DIR/.vim ]] && mv $DST_DIR/.vim $DST_DIR/.vim.bk


# Copy new config
cp -f $SRC_DIR/plug.vimrc $DST_DIR/.vimrc
vim -c "PlugInstall | qa"
#mkdir -p $DST_DIR/.vim/files/info

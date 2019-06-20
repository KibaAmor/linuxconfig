#!/bin/bash
# Program:
#   Setup configuration about dot files.
# History:
#   2016/12/16  KibaAmor     First release
#   2018/10/27  KibaAmor     Remove vim config

### Set PATH
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

### Config
SCRIPT_PATH=$(dirname ${BASH_SOURCE[0]})
SRC_DIR=$SCRIPT_PATH/config
DST_DIR=~

#######################################################################

# Exit on error
set -e


# Copy config
for file in .bash_profile .hgrc .screenrc .tmux.conf
do
    SRC=$SRC_DIR/$file
    DST=$DST_DIR/$file

    [[ -f $DST.bk ]] && rm -f $DST
    [[ -f $DST ]] && mv $DST $DST.bk

    cp -f $SRC $DST
done

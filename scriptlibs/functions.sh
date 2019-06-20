#!/bin/bash
# Program:
#   Common functions
# History:
#   2016/12/16  KibaAmor     First release

### Variables
MOVE_TO_COL="echo -en \\033[${RES_COL}G"                                                                                   
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_WARNING="echo -en \\033[1;33m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"

function tsucc() {
    $SETCOLOR_SUCCESS
    echo $@
    $SETCOLOR_NORMAL
}
function tfail() {
    $SETCOLOR_FAILURE
    echo $@
    $SETCOLOR_NORMAL
}
function twarn() {
    $SETCOLOR_WARNING
    echo $@
    $SETCOLOR_NORMAL
}

function tlog() {
    echo -n "$(tput smso)"
    echo $@
    echo -n "$(tput sgr0)"
}

function tbk(){
    [[ -f $1.bk ]] && rm -fr $1
    [[ -f $1 ]] && mv $1 $1.bk
    return 0
}
function tbknorm(){
    [[ -f $1 ]] && [[ ! -f $1.bk ]] && cp $1 $1.bk
    return 0
}


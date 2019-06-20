#!/bin/bash
# Program:
#   Install nvidia driver
# History:
#   2016/12/17  KibaAmor     First release

source ../scriptlibs/functions.sh

### Set PATH
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

### Error code
E_ROOT_PRIV_REQ=1

#######################################################################

# Exit on error
set -e

tlog "Check privileges"
if [[ $EUID -ne 0 ]]; then
    tfail "This script must be run as root"
    exit $E_ROOT_PRIV_REQ
fi

tlog "add apt repository"
add-apt-repository ppa:graphics-drivers/ppa
tlog "update apt"
apt-get update -y
tlog "search nvidia drivers"
apt-cache search nvidia


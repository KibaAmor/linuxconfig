#!/bin/bash
# Program:
#   Optmize system
# History:
#   2016/12/16  KibaAmor     First release

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

tlog "Update /etc/sysctl.conf"
tbk /etc/sysctl.conf
cp ./config/sysctl.conf /etc/sysctl.conf
sysctl -p


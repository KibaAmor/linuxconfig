#!/bin/bash
# Program:
#   Install common tools
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

# Install common tools
yum install -y epel-release # centos-release-SCL centos-release-scl-rh
yum update -y
yum install -y redhat-lsb lrzsz tmux screen the_silver_searcher ack ctags cscope dstat sar htop iotop iftop iptraf mtr socat rtorrent aria2 axel w3m sl tree nmap sysstat elinks tpp slurm linuxlogo moo love fortune cowsay cowthink cmatrix toilet figlet cal factor aafire bb rev pi rig


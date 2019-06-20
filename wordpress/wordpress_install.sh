#!/bin/bash
# Program:
#   Install wordpress
# History:
#   2015/09/07  TaberWalker     First release

source ../scriptlibs/functions.sh

### Set PATH
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

### Variables
DIST=$(lsb_release -i)

#######################################################################

# Exit on error
set -e

WORDPRESS_DIR="/usr/local/nginx/html"
if [[ $(lsb_release -r -s) == 7* ]]; then
    WORDPRESS_DIR="/var/www/html"
fi
tlog "Change directory to ${WORDPRESS_DIR}"
cd ${WORDPRESS_DIR}

tlog "Download wordpress"
rm -fr lastest.tar.gz
wget http://wordpress.org/latest.tar.gz

tlog "Extract wordpress"
tar xf latest.tar.gz

tlog "Visit http://localhost/wordpress to config wordpres"
tlog "Set Permalink is fomat to '/%year%/%postname%/'"

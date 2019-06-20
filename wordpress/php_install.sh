#!/bin/bash
# Program:
#   Install php
# History:
#   2016/12/16  KibaAmor     First release

source ../scriptlibs/functions.sh

### Set PATH
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

### Error code
E_ROOT_PRIV_REQ=1
E_UNSUPP_DIST=2

### Configs
UPDATE_SYSTEM_LIMIT=0

INSTALL_PHPFPM=1
INSTALL_ZENDOPCACHE=0
INSTALL_MEMCACHE=0

UPDATE_PHPFPM_CONFIG=1
UPDATE_MEMCACHE_CONFIG=0

START_PHPFPM=1
START_MEMCACHE=0

### Variables
MEM=$(free -m | awk '/Mem:/{print $2}')
DIST=$(lsb_release -i)

#######################################################################

# Exit on error
set -e

tlog "Check privileges"
if [[ $EUID -ne 0 ]]; then
    tfail "This script must be run as root"
    exit $E_ROOT_PRIV_REQ
fi

if [[ $UPDATE_SYSTEM_LIMIT -ne 0 ]]; then
tlog "Update system limit"
tbk /etc/security/limits.conf
cat >> /etc/security/limits.conf <<EOF
* soft nproc 65535
* hard nproc 65535
* soft nofile 65535
* hard nofile 65535
EOF
fi

if [[ $INSTALL_PHPFPM -ne 0 ]]; then
    tlog "Install PHP-FPM and plugs"
    if [[ $DIST == *CentOS* ]]; then
        yum install -y php-fpm php-cli php-pdo php-mysql php-mcrypt php-mbstring php-gd php-tidy php-xml php-xmlrpc php-pear
    elif [[ $DIST == *Debian* ]]; then
        aptitude install -y php5-fpm php5-cli php5-pdo php5-mysql php5-mcrypt php5-mbstring php5-gd php5-tidy php5-xml php5-xmlrpc php-pear php5-pecl-zendopcache php5-pecl-memcache
    else
        tfail "Unsupport distribution:$DIST"
        exit $E_UNSUPP_DIST
    fi
fi

if [[ $INSTALL_ZENDOPCACHE -ne 0 ]]; then
    tfail "Install ZendOpcache for php-fpm"
    if [[ $DIST == *CentOS* ]]; then
        yum remove -y php-eaccelerator php-xcache php-apcu # confict with php-pecl-zendopcache
        yum install php-pecl-zendopcache -y
    elif [[ $DIST == *Debian* ]]; then
        aptitude remove -y php5-eaccelerator php5-xcache php5-apcu # confict with php5-pecl-zendopcache
        aptitude install -y php5-pecl-zendopcache
    else
        tfail "Unsupport distribution:$DIST"
        exit $E_UNSUPP_DIST
    fi
fi

if [[ $INSTALL_MEMCACHE -ne 0 ]]; then
    tlog "Install Memcache for php-fpm"
    if [[ $DIST == *CentOS* ]]; then
        yum install -y memcached php-pecl-memcache
    elif [[ $DIST == *Debian* ]]; then
        aptitude install -y memcached php5-pecl-memcache
    else
        tfail "Unsupport distribution:$DIST"
        exit $E_UNSUPP_DIST
    fi
fi

# update config
if [[ $UPDATE_PHPFPM_CONFIG -ne 0 ]]; then
    tlog "Update the config of PHP-FPM and plugs"
    if [[ $DIST == *CentOS* ]]; then
        tbk /etc/php-fpm.d/www.conf
        cp ./php-fpm.conf /etc/php-fpm.d/www.conf
        sed -i "s/nogroup/nobody/g" /etc/php-fpm.d/www.conf

        sed -i "s@^pm.max_children.*@pm.max_children = $(($MEM/128))@" /etc/php-fpm.d/www.conf
        sed -i "s@^pm.start_servers.*@pm.start_servers = $(($MEM/256))@" /etc/php-fpm.d/www.conf
        sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = $(($MEM/256))@" /etc/php-fpm.d/www.conf
        sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = $(($MEM/128))@" /etc/php-fpm.d/www.conf
    elif [[ $DIST == *Debian* ]]; then
        tbk /etc/php5/fpm/php-fpm.conf
        cp ./php-fpm.conf /etc/php5/fpm/php-fpm.conf

        sed -i "s@^pm.max_children.*@pm.max_children = $(($MEM/128))@" /etc/php5/fpm/php-fpm.conf
        sed -i "s@^pm.start_servers.*@pm.start_servers = $(($MEM/256))@" /etc/php5/fpm/php-fpm.conf
        sed -i "s@^pm.min_spare_servers.*@pm.min_spare_servers = $(($MEM/256))@" /etc/php5/fpm/php-fpm.conf
        sed -i "s@^pm.max_spare_servers.*@pm.max_spare_servers = $(($MEM/128))@" /etc/php5/fpm/php-fpm.conf
    else
        tfail "Unsupport distribution:$DIST"
        exit $E_UNSUPP_DIST
    fi
fi

if [[ $UPDATE_MEMCACHE_CONFIG -ne 0 ]]; then
    tlog "Update the config of Memcache"
    sed -i "s@^OPTIONS=.*@OPTIONS=\"-l 127.0.0.1\"@" /etc/sysconfig/memcached
fi


### start
if [[ $START_PHPFPM -ne 0 ]]; then
    tlog "Start PHP-FPM"
    if [[ $DIST == *CentOS* ]]; then
        if [[ $(lsb_release -r -s) == 7* ]]; then
            systemctl enable php-fpm.service
            systemctl restart php-fpm.service
        else
            /etc/init.d/php-fpm restart
        fi
    elif [[ $DIST == *Debian* ]]; then
        /etc/init.d/php5-fpm restart
    else
        tfail "Unsupport distribution:$DIST"
        exit $E_UNSUPP_DIST
    fi
fi

if [[ $START_MEMCACHE -ne 0 ]]; then
    tlog "Start Memcache"
    service memcached restart
fi


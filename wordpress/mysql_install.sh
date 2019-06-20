#!/bin/bash
# Program:
#   Install mysql and basic setup for wordpress
# History:
#   2016/12/16  KibaAmor     First release

source ../scriptlibs/functions.sh

### Set PATH
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

### Error code
E_ROOT_PRIV_REQ=1

### Variables
DIST=$(lsb_release -i)

#######################################################################

# Exit on error
set -e

tlog "Check privileges"
if [[ $EUID -ne 0 ]]; then
    tfail "This script must be run as root"
    exit $E_ROOT_PRIV_REQ
fi

if [[ $DIST == *CentOS* ]]; then
    tlog "Install MySQL"
    if [[ $(lsb_release -r -s) == 7* ]]; then
        set +e
        rpm -ivh http://repo.mysql.com/mysql57-community-release-el7.rpm
        set -e
        yum install -y mysql-community-server
    else
        yum install -y mysql-server
    fi

    tlog "Start MySQL"
    if [[ $(lsb_release -r -s) == 7* ]]; then
        systemctl enable mysqld.service 
        systemctl start mysqld.service 
    else
        /etc/init.d/mysqld start
    fi
elif [[ $DIST == *Debian* ]]; then
    tlog "Install MySQL"
    aptitude install mysql-server -y

    tlog "Start MySQL"
    /etc/init.d/mysql start
fi

tlog "Config MySQL"
/usr/bin/mysql_secure_installation


dbrootpasswd=rootpassword
dbname=wordpress
dbuser=username
dbpasswd=password

tlog "Setup mysql"
cat << EOF | mysql --user=root --password=$dbrootpasswd
drop database if exists $dbname;
create database $dbname;
drop user '$dbuser'@'localhost';
create user '$dbuser'@'localhost' identified with mysql_native_password by '$dbpasswd';
grant all privileges on $dbname.* to '$dbuser'@'localhost';
flush privileges;
EOF

tlog "Import data to database"
mysql --user=$dbuser --password=$dbpasswd --database=$dbname < ./$dbname.sql


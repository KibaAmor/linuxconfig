#!/bin/bash
# Program:
#   Setup configuration on a fresh centos7
# History:
#   2016/12/16  KibaAmor     First release

source ../scriptlibs/functions.sh

### Set PATH
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

### Error code
E_ROOT_PRIV_REQ=1
E_NEED_REBOOT=2

### Config
NEW_HOST_NAME=kibaamor
NEW_SSH_PORT=8991

#######################################################################

# Exit on error
set -e

tlog "Check privileges"
if [[ $EUID -ne 0 ]]; then
    tfail "This script must be run as root"
    exit $E_ROOT_PRIV_REQ
fi

tlog "Set hostname"
tbk /etc/hostname
echo "$NEW_HOST_NAME" > /etc/hostname

tlog "Update system"
yum update -y

tlog "Let yum auto update"
yum install -y yum-cron
systemctl enable yum-cron.service
systemctl start yum-cron.service
systemctl status yum-cron.service

tlog "Enable firewall"
systemctl enable firewalld.service
systemctl start firewalld.service

tlog "Setup firewall to work at zone 'public'"
if [[ "$(firewall-cmd --get-default-zone)" != "public" ]]; then
    firewall-cmd --set-default-zone=public --permanent
fi

tlog "Install SELinux softwares"
# semanage
yum install -y policycoreutils-python
# seinfo, sesearch
yum install -y setools-console
# sepolicy
yum install -y policycoreutils-devel
# setsebool, restorecon
yum install -y policycoreutils
# setroubleshoot, sealert
yum install -y setroubleshoot-server

tlog "Enable SELinux"
if [[ "$(getenforce)" != "Enforcing" ]]; then
    tbknorm /etc/selinux/config
    sed -ir 's@^SELINUX=.*$@SELINUX=enforcing@g' /etc/selinux/config 
    tlog "Reboot to enable SELinux!!!"
    exit $E_NEED_REBOOT
fi

tlog "Map Linux user to SELinux"
semanage login -a -s root -r s0-s0:c0.c1023 root
semanage login -a -s user_u -r s0  __default__

tlog "Tell SELinux ssh will listen at $NEW_SSH_PORT"
set +e
semanage port -l | grep ssh_port_t | grep tcp | grep $NEW_SSH_PORT
if [[ $? -ne 0 ]]; then
    semanage port -a -t ssh_port_t -p tcp $NEW_SSH_PORT
fi
set -e

tlog "Tell firewalld ssh will listen at $NEW_SSH_PORT"
tbk /etc/firewalld/services/ssh.xml
cp /usr/lib/firewalld/services/ssh.xml /etc/firewalld/services/
sed -i "\@<port protocol=\"tcp\" port=\"i$NEW_SSH_PORT\"/>@d" /etc/firewalld/services/ssh.xml
sed -i "\@</service>@i    <port protocol=\"tcp\" port=\"$NEW_SSH_PORT\"/>" /etc/firewalld/services/ssh.xml

tlog "Tell firewalld we will use ssh"
if [[ "$(firewall-cmd --query-service=ssh)" != "yes" ]]; then
    firewall-cmd --add-service=ssh --permanent 
fi

tlog "Modify ssh port to $NEW_SSH_PORT"
tbknorm /etc/ssh/sshd_config
sed -i '/\<Port\>/d' /etc/ssh/sshd_config
echo "Port $NEW_SSH_PORT" >> /etc/ssh/sshd_config
systemctl restart sshd.service
systemctl restart firewalld.service


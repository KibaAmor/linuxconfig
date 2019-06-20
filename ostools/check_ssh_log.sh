#!/bin/bash
# Program:
#   Prohibition ssh login with too many failed
# History:
#   2016/12/16  KibaAmor     First release

# Set PATH
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Set temp filename
TMP_FILE="/tmp/ssh_login_failed_count.log"

# Set max ssh failed times
MAX_TRY_TIMES="6"

cat /var/log/secure | awk '/Failed/{print $(NF-3)}' | sort | uniq -c | awk '{print $2"="$1;}' > $TMP_FILE

for i in $(cat $TMP_FILE)
do
    IP=$(echo  $i | awk -F= '{print $1;}')
    NUM=$(echo $i | awk -F= '{print $2;}')
    if [[ $NUM -gt $MAX_TRY_TIMES ]]; then
        grep $IP /etc/hosts.deny > /dev/null
        if [[ $? -gt 0 ]]; then
            echo "sshd:$IP:deny" >> /etc/hosts.deny
        fi
    fi
done


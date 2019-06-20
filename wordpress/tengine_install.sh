#!/bin/bash
# Program:
#   Install TEngine2.1.2
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
UPDATE_SYSTEM=1
INSTALL_TENGINE=1
UPDATE_TENGINE_CONFIG=1
START_TENGINE=1

### Variables
DIST=$(lsb_release -i)
TENGINE_VERSION="tengine-2.2.0"

#######################################################################

# Exit on error
set -e

### work
if [[ $UPDATE_SYSTEM -ne 0 ]]; then
    tlog "Update system"
    if [[ $DIST == *CentOS* ]]; then
        yum update -y
    elif [[ $DIST == *Debian* ]]; then
        aptitude update -y
    else
        tfail "Unsupport distribution:$DIST"
        exit $E_UNSUPP_DIST
    fi
fi

if [[ $INSTALL_TENGINE -ne 0 ]]; then
    if [[ $DIST == *CentOS* ]]; then
        tlog "Install jemalloc"
        yum install -y jemalloc-devel

        #tlog "Install GeoIP"
        #yum install -y GeoIP-devel

        tlog "Install OpenSSL"
        yum install -y openssl-devel

        tlog "Install pcre"
        yum install -y pcre-devel
    elif [[ $DIST == *Debian* ]]; then
        tlog "Install jemalloc"
        aptitude install -y libjemalloc-dev

        #tlog "Install GeoIP"
        #aptitude install -y libgeoip-dev

        tlog "Install OpenSSL"
        aptitude install -y libcurl4-openssl-dev

        tlog "Install pcre"
        aptitude install -y libpcre3-dev
    else
        tfail "Unsupport distribution:$DIST"
        exit $E_UNSUPP_DIST
    fi

    tlog "Download ${TENGINE_VERSION}"
    wget http://tengine.taobao.org/download/${TENGINE_VERSION}.tar.gz

    tlog "Extract ${TENGINE_VERSION}"
    tar xf ${TENGINE_VERSION}.tar.gz
    cd ${TENGINE_VERSION}

    tlog "Configure ${TENGINE_VERSION}"
    ./configure --user=nobody --group=nogroup \
        --prefix=/usr/local/nginx/ \
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/lock/nginx.lock \
        --http-proxy-temp-path=/var/www/temp/proxy_temp/ \
        --http-fastcgi-temp-path=/var/www/temp/fastcgi_temp/ \
        --http-uwsgi-temp-path=/var/www/temp/uwsgi_temp/ \
        --http-scgi-temp-path=/var/www/temp/scgi_temp/ \
        --http-client-body-temp-path=/var/www/temp/client_body_temp/ \
        --with-jemalloc \
        --with-http_ssl_module \
        --with-http_stub_status_module \
        --with-http_gzip_static_module \
        --with-http_reqstat_module=shared \
        --with-http_concat_module=shared

    tlog "Compile ${TENGINE_VERSION}"
    make -j3

    tlog "Install ${TENGINE_VERSION}"
    make install

    tlog "Remove ${TENGINE_VERSION} compile file"
    cd ..
    rm -fr ./${TENGINE_VERSION}/
fi

# update
if [[ $UPDATE_TENGINE_CONFIG -ne 0 ]]; then
    tlog "Update the config of ${TENGINE_VERSION}"
    tbk /etc/nginx/nginx.conf
    openssl dhparam -out /etc/ssl/certs/kibazencn_dhparam2048.pem 2048
    cp ./nginx.conf /etc/nginx/nginx.conf
    sed -i "s@nginx/\$nginx_version@Apache/2.2.21@" /etc/nginx/fastcgi_params
    mkdir -p /var/www/temp/
    if [[ $DIST == *CentOS* ]]; then
        sed -i "s/nogroup/nobody/g" /etc/nginx/nginx.conf
    fi

    tlog "Test ${TENGINE_VERSION} config file"
    nginx -t
fi

# SELinux setup
if [[ "$(getenforce)" != "Disabled" ]]; then
    semanage fcontext -a -t httpd_exec_t -f f '/usr/sbin/nginx'
    restorecon -Fv /usr/sbin/nginx

    semanage fcontext -a -t httpd_config_t -f f '/etc/nginx/nginx\.conf'
    restorecon -Fv /etc/nginx/nginx.conf

    semanage fcontext -a -t httpd_log_t '/var/log/nginx/.*'
    test -d /var/log/nginx/ || mkdir -p /var/log/nginx/
    restorecon -FR /var/log/nginx/

    semanage fcontext -a -t httpd_var_run_t '/var/run/nginx\.pid'
    touch /var/run/nginx.pid
    restorecon -Fv /var/run/nginx.pid
    rm -f /var/run/nginx.pid

    semanage fcontext -a -t httpd_lock_t '/var/lock/nginx\.lock'
    touch /var/run/nginx.lock
    restorecon -Fv /var/run/nginx.lock
    rm -f /var/run/nginx.lock

    semanage fcontext -a -t httpd_modules_t '/usr/local/nginx/modules/.*'
    restorecon -FRv /usr/local/nginx/modules/

    semanage fcontext -a -t httpd_sys_content_t  '/usr/local/nginx/html/.*'
    restorecon -FRv /usr/local/nginx/html/

    semanage fcontext -a -t httpd_sys_rw_content_t '/var/www(/.*)?'
    #semanage fcontext -a -t httpd_sys_content_t '/var/www(/.*)?'
    semanage fcontext -a -t httpd_tmp_t '/var/www/temp/.*'
    #semanage fcontext -a -t httpd_sys_script_exec_t -f f '/var/www/wordpress/.*\.php'
    #semanage fcontext -a -t httpd_sys_script_exec_t -f f '/var/www/wordpress/wp-includes/.*\.php'
    #semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/wordpress/wp-content/upgrade(/.*)?'
    #semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/wordpress/wp-content/uploads(/.*)?'
    restorecon -FR /var/www/

    setsebool -P httpd_setrlimit 1
    setsebool -P httpd_unified 1
    setsebool -P httpd_enable_cgi 1
    setsebool -P httpd_builtin_scripting 1
    setsebool -P httpd_run_stickshift 1
fi

# regist service
if [[ $(lsb_release -r -s) == 7* ]]; then
    tlog "Regist nginx service"
    tbk /usr/lib/systemd/system/nginx.service
    cp ./nginx.service /usr/lib/systemd/system/nginx.service
    systemctl daemon-reload
    firewall-cmd --add-service=http --permanent 
    firewall-cmd --add-service=https --permanent 
    systemctl restart firewalld.service
fi

# start
if [[ $START_TENGINE -ne 0 ]]; then
    tlog "Start ${TENGINE_VERSION}"
    if [[ $(lsb_release -r -s) == 7* ]]; then
       systemctl enable nginx.service 
       systemctl start nginx.service
    else
        nginx
    fi
fi


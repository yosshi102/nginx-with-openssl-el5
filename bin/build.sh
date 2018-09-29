#!/bin/bash

wget --no-check-certificate https://nginx.org/packages/mainline/centos/5/SRPMS/nginx-1.11.12-1.el5.ngx.src.rpm
rpm -ivh nginx-1.11.12-1.el5.ngx.src.rpm


OUTPUT_DIR=/usr/src/redhat
NGINX_SPEC=$OUTPUT_DIR/SPECS/nginx.spec
NGINX_VERSION=1.15.4
OPENSSL=1.1.1
OPENSSL_DIR=/usr/src

wget --no-check-certificate https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz -O $OUTPUT_DIR/SOURCES/nginx-$NGINX_VERSION.tar.gz
wget https://www.openssl.org/source/openssl-$OPENSSL.tar.gz -O $OPENSSL_DIR/openssl-$OPENSSL.tar.gz
tar xvzf $OPENSSL_DIR/openssl-$OPENSSL.tar.gz -C $OPENSSL_DIR

sed -i "s|main_version 1.11.12|main_version $NGINX_VERSION|g " $NGINX_SPEC
sed -i "s|WITH_LD_OPT |WITH_LD_OPT -m32 -march=i686 |g " $NGINX_SPEC

sed -i "s|--with-http_ssl_module|--with-http_ssl_module --with-openssl=$OPENSSL_DIR/openssl-$OPENSSL --with-openssl-opt=-fpic|g" $NGINX_SPEC

echo "%__global_cflags $(rpm --eval %{__global_cflags}) -Wno-error" >> ~/.rpmmacros

cat ~/.rpmmacros

setarch i686 rpmbuild  -bb --target=i686 --define "rhel 5"  $NGINX_SPEC



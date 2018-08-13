# nginx with openssl for centos5

This creates an nginx rpm file containing openssl for centos 5.

## target

    nginx 1.15.2
    openssl 1.0.2o

Building openssl 1.1.0 requires perl 5.10 or more, so it can not be built with centos 5.

## require

windows

    docker for windows
    powershell

linux

    docker

## how to build building images

all platform

    docker build -t nginx-with-openssl-el5:centos5 .

## how to build rpm 

windows

    docker run --rm -v ${pwd}/bin:/tmp/bin -v ${pwd}/rpmbuild:/usr/src/redhat/RPMS nginx-with-openssl-el5:centos5

linux

    docker run --rm -v $(pwd)/bin:/tmp/bin -v $(pwd)/rpmbuild:/usr/src/redhat/RPMS nginx-with-openssl-el5:centos5


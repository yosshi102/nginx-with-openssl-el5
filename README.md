# nginx with openssl for centos5

This creates an nginx rpm file containing openssl for centos 5.

## target

    nginx 1.15.7
    openssl 1.1.1a

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


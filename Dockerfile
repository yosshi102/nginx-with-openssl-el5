FROM centos:5
COPY CentOS-Base.repo /etc/yum/repos.d/CentOS-Base.repo

RUN yum clean all
RUN yum -y install make autoconf automake gcc redhat-rpm-config rpm-build zlib-devel pcre-devel openssl-devel wget
WORKDIR /root

RUN mkdir /tmp/bin
COPY bin/build.sh /tmp/bin
CMD /tmp/bin/build.sh

RUN mkdir -p /usr/src/redhat/{RPMS,BUILD,SOURCES,SPECS}

ARG PERL_VERSION=5.28.0

RUN cd /usr/src && \
    wget http://www.cpan.org/src/5.0/perl-${PERL_VERSION}.tar.gz && \
    tar xvzf perl-${PERL_VERSION}.tar.gz
RUN cd /usr/src/perl-${PERL_VERSION} && \
    sh Configure -des -Dusethreads -Dinc_version_list=none && \
    make && \
    make install
RUN perl -v
RUN yum install -y glibc-devel.i386 setarch 

RUN wget --no-check-certificate https://nginx.org/packages/mainline/centos/5/SRPMS/nginx-1.11.12-1.el5.ngx.src.rpm
RUN rpm -ivh nginx-1.11.12-1.el5.ngx.src.rpm
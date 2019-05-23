FROM centos:5
COPY CentOS-Base.repo /etc/yum/repos.d/CentOS-Base.repo

RUN yum clean all
RUN yum -y install make autoconf automake gcc redhat-rpm-config rpm-build zlib-devel.x86_64 pcre-devel.x86_64 openssl-devel.x86_64 wget
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

RUN wget --no-check-certificate https://nginx.org/packages/mainline/centos/5/SRPMS/nginx-1.11.12-1.el5.ngx.src.rpm
RUN rpm -ivh nginx-1.11.12-1.el5.ngx.src.rpm

RUN wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
RUN yum install -y devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++ devtoolset-2-gcc-gfortran

FROM centos:6
MAINTAINER Chris Fraser

## Required Packages
RUN yum -y update; yum clean all
RUN yum -y groupinstall "Development Tools"
RUN yum -y install epel-release
RUN yum -y install wget git ant libevent-devel automake libtool flex bison gcc-c++ openssl-devel make cmake doxygen.x86_64 glib-devel python-devel bzip2-devel svn libevent-devel krb5-workstation openldap-devel db4-devel python-setuptools python-pip cyrus-sasl* postgresql postgresql-server ant-nodeps lzo-devel lzop
RUN pip install --upgrade pip
RUN pip install allpairs pytest pytest-xdist paramiko texttable prettytable sqlparse psutil==0.7.1 pywebhdfs gitpython jenkinsapi

## JDK
ARG jdk_version=jdk1.7.0_79
ARG jdk_download_version=7u79
WORKDIR /tmp
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/${jdk_download_version}-b15/jdk-${jdk_download_version}-linux-x64.rpm"
RUN yum -y localinstall jdk-${jdk_download_version}-linux-x64.rpm
RUN alternatives --install /usr/bin/java java /usr/java/${jdk_version}/bin/java 999
RUN alternatives --set java /usr/java/${jdk_version}/bin/java

## Boost
RUN yum -y install boost-devel
RUN yum -y install tar

## LLVM
WORKDIR /opt
RUN wget http://llvm.org/releases/3.3/llvm-3.3.src.tar.gz
RUN tar xvf llvm-3.3.src.tar.gz
WORKDIR llvm-3.3.src/tools/
RUN svn co http://llvm.org/svn/llvm-project/cfe/tags/RELEASE_33/final/ clang
WORKDIR ../projects
RUN svn co http://llvm.org/svn/llvm-project/compiler-rt/tags/RELEASE_33/final/ compiler-rt
WORKDIR ..
RUN ./configure --with-pic
RUN make -j$(nproc) REQUIRES_RTTI=1
RUN make install


## Postgresql

RUN service postgresql initdb
RUN sed -i 's/ident$/trust/g' /var/lib/pgsql/data/pg_hba.conf
RUN service postgresql start \
    && sleep 5 \
    && sudo -u postgres psql -c " \
        CREATE ROLE hiveuser LOGIN PASSWORD 'password'; \
        ALTER ROLE hiveuser WITH CREATEDB;"

# TODO: start postgresql

CMD ["echo", "Build container for Impala"]

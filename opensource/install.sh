#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2017 wystan
##
##       filename: install.sh
##    description: centos6.8 development env setup script
##        created: 2017-10-17 14:28:29
##         author: wystan
##
###########################################################################

function inst_aliyun_repo() {
    yum install -y wget
    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
    yum makecache
}


function inst_dev() {
    yum install -y gcc gcc-c++ make libtool man cmake unzip
    yum install -y bzip2 mkdirhier tree
    yum install -y vim ctags cscope
    yum install -y git
    yum install -y python-devel.x86_64 pcre-devel.x86_64
}

function inst_mysql() {
    cur_dir=`pwd`
    #wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm && rpm -ivh mysql-community-release-el7-5.noarch.rpm
    #rm -f mysql-community-release-el7-5.noarch.rpm
    #yum install mysql.x86_64
    #cd /usr/lib64/mysql/
    #ln -s libmysqlclient.so.16 libmysqlclient.so
    yum -y install mysql-server
    yum -y install mysql-devel.x86_64
    cd $cur_dir
}

function inst_mydev() {
    cur_dir=`pwd`
    mkdir -p ~/usr/project/github && cd ~/usr/project/github
    git clone https://github.com/oswystan/dev
    cd dev
    ./setup_env.sh
    cd $cur_dir
}

function inst_gcc_4.8.2() {
    cur_dir=`pwd`
    wget http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2
    tar -jxvf gcc-4.8.2.tar.bz2
    cd gcc-4.8.2
    ./contrib/download_prerequisites
    mkdir build && cd build
    ../configure -enable-checking=release -enable-languages=c,c++ -disable-multilib
    make -j4
    make install
    cd $cur_dir
}

function inst_gcc_4.9.4() {
    cur_dir=`pwd`
    wget http://ftp.gnu.org/gnu/gcc/gcc-4.9.4/gcc-4.9.4.tar.bz2
    tar -jxvf gcc-4.9.4.tar.bz2
    cd gcc-4.9.4
    ./contrib/download_prerequisites
    mkdir build && cd build
    ../configure -enable-checking=release -enable-languages=c,c++ -disable-multilib
    make -j4
    make install
    cd $cur_dir
}
function inst_gcc_5.4.0() {
    cur_dir=`pwd`
    wget http://ftp.gnu.org/gnu/gcc/gcc-5.4.0/gcc-5.4.0.tar.bz2
    tar -jxvf gcc-5.4.0.tar.bz2
    cd gcc-5.4.0
    ./contrib/download_prerequisites
    mkdir build && cd build
    ../configure -enable-checking=release -enable-languages=c,c++ -disable-multilib
    make -j4
    make install
    cd $cur_dir
}


###########################################################################
#inst_aliyun_repo
#inst_dev
#inst_mydev
#inst_mysql
#inst_gcc_4.8.2
#inst_gcc_4.9.4
#inst_gcc_5.4.0

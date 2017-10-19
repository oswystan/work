#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2017 wystan
##
##       filename: glog.sh
##    description:
##        created: 2017-10-18 04:24:15
##         author: wystan
##
###########################################################################

function glog_dl() {
    echo "##############################################"
    echo "###########  DOWNLOADING  ####################"
    echo "##############################################"
    git clone https://github.com/google/glog
    cur_dir=`pwd`
    cd glog
    git checkout -b local_dev v0.3.5
    cd $cur_dir
}

function glog_mk() {
    echo "##############################################"
    echo "################ BUILDING ####################"
    echo "##############################################"
    cur_dir=`pwd`
    cd glog
    set -eu
    autoreconf -i
    ./configure --prefix=$cur_dir
    make -j4
    make install
    cd $cur_dir
}

###########################################################################
glog_dl
glog_mk

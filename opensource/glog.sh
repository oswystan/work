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

function _start() {
    echo "==> start $1 ..."
    echo "-------------------------------------------"
}

function _end() {
    if [ $1 -eq 0 ]; then
        echo "---------------- SUCCESS ------------------"
        echo ""
    else
        echo "**************** FAILED *******************"
        echo ""
        exit $1
    fi
}

function do_download() {
    _start "downloading"
        cur_dir=`pwd`
        git clone https://github.com/google/glog && \
        cd glog && \
        git checkout -b local_dev v0.3.5 && \
        cd $cur_dir
    _end $?
}

function do_mk() {
    _start "building"
        cur_dir=`pwd`
        cd glog && \
        set -eu && \
        autoreconf -i && \
        ./configure --prefix=$cur_dir && \
        make -j4 && \
        make install && \
        cd $cur_dir
    _end $?
}

###########################################################################
do_download
do_mk


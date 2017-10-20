#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2017 wystan
##
##       filename: hiredis.sh
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
        git clone https://github.com/redis/hiredis && \
        cd hiredis && \
        git checkout -b local_dev v0.13.3 && \
        cd $cur_dir
    _end $?
}

function do_mk() {
    _start "building"
        cur_dir=`pwd`
        cd hiredis && \
        make PREFIX=$cur_dir -j4 && \
        make PREFIX=$cur_dir install && \
        cd $cur_dir
    _end $?
}

###########################################################################
do_download
do_mk

#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2017 wystan
##
##       filename: boost.sh
##    description:
##        created: 2017-10-18 04:06:11
##         author: wystan
##
###########################################################################

function _start() {
    echo "==> start $1 ..."
    echo "-------------------------------------------"
}

function _end() {
    [[ $1 -ne 0 ]] && printf -- '**************** FAILED *******************\n\n' && exit $1
    [[ $1 -eq 0 ]] && printf -- '---------------- SUCCESS ------------------\n\n'
}

function do_download() {
    _start "downloading"
        wget https://dl.bintray.com/boostorg/release/1.65.1/source/boost_1_65_1.tar.bz2 && \
        tar jxvf boost_1_65_1.tar.bz2
    _end $?
}

function do_mk() {
    _start "building"
        cur_dir=`pwd`
        cd boost_1_65_1 && \
        ./bootstrap.sh --prefix=$cur_dir && \
        ./b2 -j4 && \
        ./b2 install && \
        cd $cur_dir
    _end $?
}

###########################################################################
do_download
do_mk


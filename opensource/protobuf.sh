#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2017 wystan
##
##       filename: pb.sh
##    description:
##        created: 2017-10-18 06:50:16
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
        cur_dir=`pwd`
        git clone https://github.com/google/protobuf.git && \
        cd protobuf && \
        git checkout -b local_dev v3.4.0 && \
        cd $cur_dir
    _end $?
}

function do_mk() {
    _start "building"
        cur_dir=`pwd`
        cd protobuf && \
            ./autogen.sh && ./configure --prefix=$cur_dir && \
            make -j4 && make install && \
        cd $cur_dir
    _end $?
}

###########################################################################
do_download
do_mk

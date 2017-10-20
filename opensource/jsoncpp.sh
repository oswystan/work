#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2017 wystan
##
##       filename: jsoncpp.sh
##    description:
##        created: 2017-10-18 06:00:31
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
        git clone https://github.com/open-source-parsers/jsoncpp && \
        cd jsoncpp && \
        git checkout -b local_dev 1.0.0 && \
        cd $cur_dir
    _end $?
}

function do_mk() {
    _start "building"
        cur_dir=`pwd`
        cd jsoncpp && \
        mkdir build && \
        cd build && \
        cmake -DCMAKE_BUILD_TYPE=release -DJSONCPP_LIB_BUILD_SHARED=ON -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$cur_dir .. && \
        make -j4 && make install && \
        cd $cur_dir
    _end $?
}

###########################################################################
do_download
do_mk

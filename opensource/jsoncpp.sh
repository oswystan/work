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

function jsoncpp_dl() {
    echo "##############################################"
    echo "###########  DOWNLOADING  ####################"
    echo "##############################################"
    git clone https://github.com/open-source-parsers/jsoncpp
    cur_dir=`pwd`
    cd jsoncpp
    git checkout -b local_dev 1.0.0
    cd $cur_dir
}

function jsoncpp_mk() {
    echo "##############################################"
    echo "################ BUILDING ####################"
    echo "##############################################"
    cur_dir=`pwd`
    cd jsoncpp && \
        mkdir build && \
        cd build && \
        cmake -DCMAKE_BUILD_TYPE=release -DJSONCPP_LIB_BUILD_SHARED=ON -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$cur_dir .. && \
        make -j4 && make install
    cd $cur_dir
    echo "##############################################"
    echo "################### DONE #####################"
    echo "##############################################"
}

###########################################################################
jsoncpp_dl
jsoncpp_mk

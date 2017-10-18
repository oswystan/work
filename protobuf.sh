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

function pb_dl() {
    echo "##############################################"
    echo "###########  DOWNLOADING  ####################"
    echo "##############################################"
    git clone https://github.com/google/protobuf.git
    cur_dir=`pwd`
    cd protobuf
    git checkout -b local_dev v3.4.0
    cd $cur_dir
}

function pb_mk() {
    echo "##############################################"
    echo "################ BUILDING ####################"
    echo "##############################################"
    cur_dir=`pwd`
    cd protobuf && \
        ./autogen.sh && ./configure --prefix=$cur_dir && \
        make -j4 && make install && \
    cd $cur_dir
    echo "##############################################"
    echo "################### DONE #####################"
    echo "##############################################"
}

###########################################################################
#pb_dl
pb_mk

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

function hiredis_dl() {
    echo "##############################################"
    echo "###########  DOWNLOADING  ####################"
    echo "##############################################"
    git clone https://github.com/redis/hiredis
    cur_dir=`pwd`
    cd hiredis
    git checkout -b local_dev v0.13.3
    cd $cur_dir
}

function hiredis_mk() {
    echo "##############################################"
    echo "################ BUILDING ####################"
    echo "##############################################"
    cur_dir=`pwd`
    cd hiredis
    make PREFIX=$cur_dir -j4
    make PREFIX=$cur_dir install
    cd $cur_dir
    echo "##############################################"
    echo "################### DONE #####################"
    echo "##############################################"
}

###########################################################################
hiredis_dl
hiredis_mk

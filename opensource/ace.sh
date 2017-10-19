#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2017 wystan
##
##       filename: ace.sh
##    description:
##        created: 2017-10-17 12:38:29
##         author: wystan
##
###########################################################################

function ace_dl() {
    echo "##############################################"
    echo "###########  DOWNLOADING  ####################"
    echo "##############################################"
    wget http://download.dre.vanderbilt.edu/previous_versions/ACE-6.3.4.tar.bz2
    tar jxvf ACE-6.3.4.tar.bz2
}

function ace_config() {
    echo "##############################################"
    echo "################  CONFIG  ####################"
    echo "##############################################"
    cur_dir=`pwd`
    cd ACE_wrappers/
    echo "INSTALL_PREFIX = ${cur_dir}" > include/makeinclude/platform_macros.GNU
    cat include/makeinclude/platform_linux.GNU >>include/makeinclude/platform_macros.GNU
    cp ace/config-linux.h ace/config.h
    cd $cur_dir
}

function fix_build_error() {
    echo "##############################################"
    echo "######### FIXING BUILD ERROR #################"
    echo "##############################################"
    cat <<!EOF > ACE_wrappers/apps/gperf/tests/ada.cpp
const char *in_word_set (const char *str, unsigned int len) {
    if (!str || !len) {
        return (const char*)0;
    }
    return str;
}
!EOF
}

function ace_mk() {
    echo "##############################################"
    echo "################ BUILDING ####################"
    echo "##############################################"
    cur_dir=`pwd`
    cd ACE_wrappers/
    export ACE_ROOT=`pwd`
    export LD_LIBRARY_PATH=$ACE_ROOT/lib:$LD_LIBRARY_PATH
    make -j 4
    make install
    cd $cur_dir

    echo "##############################################"
    echo "################ DONE ########################"
    echo "##############################################"
}

###########################################################################
ace_dl
ace_config
fix_build_error
ace_mk

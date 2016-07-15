#!/bin/bash
##########################################################
##
## contab configuration:
##     0 3 * * * /home/andbase/usr/src/sh/daily.sh
##
##########################################################
log_file="/tmp/daily/log.txt"

base_dir="/home/andbase/usr/project/le/turbo/src/daily"

export USE_CCACHE=1
export CCACHE_DIR=./.ccache
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
export PATH="${PATH}:${JAVA_HOME}/bin:/home/andbase/bin"

################################
# some basic functions for log
################################
log_start()
{
    strNow=`date +'%Y-%m-%d %H:%M:%S'`
    echo "[${strNow}]##########################################################"
    echo "[${strNow}] start program  : $0"
    echo "[${strNow}]##########################################################"
    echo ""
}

logi()
{
    strNow=`date +'%Y-%m-%d %H:%M:%S'`
    echo "[${strNow}] INFO:$*"
}

logw()
{
    strNow=`date +'%Y-%m-%d %H:%M:%S'`
    echo "[${strNow}] WARN:$*"
}

loge()
{
    strNow=`date +'%Y-%m-%d %H:%M:%S'`
    echo "[${strNow}]ERROR:$*"
}

log_end()
{
    strNow=`date +'%Y-%m-%d %H:%M:%S'`
    echo ""
    echo "[${strNow}]##########################################################"
    echo "[${strNow}] finished $0"
    echo "[${strNow}]##########################################################"
}
safe_exec()
{
    if [ $# -eq 0 ]; then
        exit 1
    fi

    $*
    if [ $? -ne 0 ]; then
        loge "fail to do [$*]"
        exit 1
    fi
}

download() {
    safe_exec cd $base_dir
    rm -rf ./*
    repo sync -cdj8 --no-tags
}

setup_ccache() {
    cd $base_dir
    prebuilts/misc/linux-x86/ccache/ccache -M 16G
}

build() {
    cd $base_dir
    . ./build/envsetup.sh && lunch le_turbo-eng
    make -j 14
}

do_work()
{
    log_start

    env
    download
    setup_ccache
    build

    log_end
}

################################
## main
################################
mkdir -p `dirname $log_file`

if [ $# -eq 0 ]; then
    do_work >$log_file 2>&1
else
    $*
fi

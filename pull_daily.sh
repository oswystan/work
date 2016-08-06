#!/bin/bash
log_file="/tmp/winner/pull_daily.log"

cur_date=`date '+%Y%m%d'`
srv="imgrepo-cnbj-mobile.devops.letv.com"
mnt_dir="/Users/winner/usr/tmp/dailybuild"
dst_dir="/Users/winner/usr/tmp/turbo/daily/$cur_date"

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
chk_mnt()
{
    is_mount=`mount|grep $srv|wc -l`
    if [ $is_mount -eq 0 ]; then
        safe_exec mount -t smbfs //wangyu10@imgrepo-cnbj-mobile.devops.letv.com/dailybuild $mnt_dir
    fi
}
pull_daily()
{
    dirs=`ls $mnt_dir/coral/cn/le_turbo/daily/$cur_date|grep '.*le_x950_ruby_la2.0_dev_bsp.*userdebug'`
    if [[ $dirs == '' ]]; then
        echo "NO images avaliable.."
    else
        ls $mnt_dir/coral/cn/le_turbo/daily/$cur_date/$dirs
        if [ -d $dst_dir ]; then
            echo "remove $dst_dir ..."
            rm -rf $dst_dir
        fi
        safe_exec mkdir -p $dst_dir
        echo "copy images ..."
        safe_exec cp -R $mnt_dir/coral/cn/le_turbo/daily/$cur_date/$dirs/le_turbo_fastboot $dst_dir/
    fi
}

do_work()
{
    log_start

    chk_mnt
    pull_daily

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

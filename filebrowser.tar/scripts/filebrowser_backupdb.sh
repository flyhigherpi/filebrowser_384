#!/bin/sh

export KSROOT=/koolshare
source $KSROOT/scripts/base.sh
eval $(dbus export filebrowser_)
alias echo_date='echo 【$(date +%Y年%m月%d日\ %X)】:'
dbpath=/koolshare/bin/filebrowser.db
dbpath_tmp=/tmp/bin/filebrowser.db
LOG_FILE="/tmp/filebrowser.log"

if [ ! -f "$dbpath" ]; then
    #/koolshare/bin 数据库不存在则复制
    cp -rf $dbpath_tmp $dbpath
    echo_date "备份数据库" >> $LOG_FILE
else
    new=$(md5sum $dbpath_tmp | awk '{print $1}')
    old=$(md5sum $dbpath | awk '{print $1}') 
    #新老文件不一致则重新复制
    if [ "$new" != "$old" ] ; then
        cp -rf $dbpath_tmp $dbpath
        echo_date "数据库变化，重新备份数据库" >> $LOG_FILE
    fi
    #echo_date "数据库无变化" >> $LOG_FILE
fi


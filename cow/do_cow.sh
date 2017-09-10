#!/bin/bash
# Program:
#   ssss
# History:
#   ssss
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

sleep 15 #等15s

sudo dmesg -c >> /dev/null #清空日志文件dmesg中的信息

cache_clear

#sleep 5

#time mussh -m 5 -b -H ip.txt -c "time dd=/dev/zero bs=1 count=1 >> file"
pssh -h ip.txt -p 100 -i /root/bin/do_cow

sudo dmesg -c > data #结果输出到data文件中

#cat data

./awk_20.sh data #每次结果输出到result_file变量指定的文件中


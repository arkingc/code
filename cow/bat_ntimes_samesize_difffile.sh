#!/bin/bash
# Program:
# 	ssss
# History:
# 	ssss
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

awk_file="awk_20.sh"
result_file="result"

if [ ! -n "$1" ];then
    read -p "input the num of ct you want to create:" ct_num
    read -p "input the file size which will cow:" file_size
    read -p "input times you want to test:" test_times
elif [ ! -n "$2" ];then
    ct_num=$1
    read -p "input the file size which will cow:" file_size
    read -p "input times you want to test:" test_times
elif [ ! -n "$3" ];then
    ct_num=$1
    file_size=$2
    read -p "input times you want to test:" test_times
else
    ct_num=$1
    file_size=$2
    test_times=$3
fi

for j in $(seq 1 $test_times)
do
    ./run_samesize_difffile.sh $ct_num $file_size #启动容器

    sleep 15 #等15s

    sudo dmesg -c >> /dev/null #清空日志文件dmesg中的信息
    
    cache_clear #清缓存

    pssh -h ip.txt bash -c "dd=/dev/zero bs=1 count=1 >> file"
        
    sudo dmesg -c > data #结果输出到data文件中

    cat data

    ./$awk_file data >> $result_file #每次结果输出到result_file变量指定的文件中

    #加入分隔符
    #echo "-------------------------------" >> $result_file
    echo >> $result_file

    ./rm_container.sh $ct_num #停止、删除容器
done

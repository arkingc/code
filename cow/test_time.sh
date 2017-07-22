#!/bin/bash
# Program:
# 	ssss
# History:
# 	ssss
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

file_array=("file_64M" "file_128M" "file_256M" "file_512M" "file_1024M")
declare -i container_num=3
result_filename="result.txt"

#外层循环，遍历每个文件，每次测试一个文件的cow
for i in $(seq 1 5)
do
    declare -i index=$i-1
    file_name=${file_array[$index]}
    
    echo ===========$file_name========= >> $result_filename
    #内层循环，每种大小文件的cow测试20次
    for j in $(seq 1 20)
    do
        ./run_container.sh $container_num #启动容器

        ./cache_clear.sh    #清缓存

        mussh -m $container_num -b -H ip.txt -c "time dd=/dev/zero bs=1 count=1 >> $file_name" | grep real >> $result_filename #并行执行cow
        
        echo >> $result_filename #每次测试结尾加入一行空行
        
        ./rm_container.sh $container_num #停止、删除容器

    done

    #每测试一种大小的文件，末尾加4行空行
    echo >> $result_filename
    echo >> $result_filename
    echo >> $result_filename
    echo >> $result_filename

done

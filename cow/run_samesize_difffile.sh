#!/bin/bash
# Program:
# 	run n container wite n different file(m MB)
# History:
# 	2017.07.21
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

if [ ! -n "$1" ];then
    read -p "input the num of ct you want to create:" ct_num
    read -p "input the file size which will cow:" file_size
elif [ ! -n "$2" ];then
    ct_num=$1
    read -p "input the file size which will cow:" file_size
else
    ct_num=$1
    file_size=$2
fi

for i in $(seq 1 $ct_num)
do 
    docker run -td --name ct$i cow/ssh:$file_size$i /bin/bash

    declare -i ip=$i+1

    if [ $i -eq 1 ];then
        echo "root@172.17.0.$ip" > ip.txt  
    else
        echo "root@172.17.0.$ip" >> ip.txt
    fi
done

for j in $(seq 1 $ct_num)
do
    docker exec ct$j /etc/init.d/ssh start
done

#!/bin/bash
# Program:
# 	ssss
# History:
# 	ssss
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

if [ ! -n "$1" ];then #如果没有参数指明删除多少个容器，则提示用户键入(删掉$1的双引号会出错)
    read -p "input the number of containers you want to rm:" num_ct
else #否则，直接将第一个参数作为删除的容器个数赋值给num_ct
   num_ct=$1
fi

#echo "删除 $num_ct 个容器"
#exit

for i in $(seq 1 $num_ct)
do
    docker stop ct$i
    docker rm ct$i
done


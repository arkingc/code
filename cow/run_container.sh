#!/bin/bash
# Program:
# 	ssss
# History:
# 	ssss
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

if [ ! -n "$1" ];then #如果没有参数指明创建多少个容器，则提示用户键入(删掉$1的双引号会出错)
    read -p "input the number of containers you want to run:" num_ct
else #否则，直接将第一个参数作为创建的容器个数复制给num_ct
   num_ct=$1
fi

#echo "创建 $num_ct 个容器"
#exit

#num_ct数值检查(待实现)

#创建容器并将ip信息加入到ip.txt中
for i in $(seq 1 $num_ct)
do
    docker run -td --name ct$i cow/ssh:all /bin/bash
    
    declare -i ip=$i+1

    if [ $i -eq 1 ];then
      echo "root@172.17.0.$ip" > ip.txt  
    else
        echo "root@172.17.0.$ip" >> ip.txt
    fi
done

#每个容器启动ssh
for j in $(seq 1 $num_ct)
do
    docker exec ct$j /etc/init.d/ssh start
done

#!/bin/bash

if [ ! -n "$1" ]
then
    read -p "input number of ct you want to run:" ct_num
    read -p "input base size(MB),don't input unit:" base_size
elif [ ! -n "$2" ]
then
    ct_num=$1
    read -p "input base size(MB),don't input unit:" base_size
else
    ct_num=$1
    base_size=$2
fi

for i in $(seq 1 $ct_num)
do
    declare -i size=i*base_size

    docker run -td --name ct$i -v ~/bin:/root/bin cow/ssh:${size}M1 /bin/bash

    declare -i ip=$i+1

    if [ $i -eq 1 ];then
        echo "root@172.17.0.$ip" > ip.txt  
    else
        echo "root@172.17.0.$ip" >> ip.txt
    fi
done

#每个容器启动ssh
for j in $(seq 1 $ct_num)
do
    docker exec ct$j /etc/init.d/ssh start
done

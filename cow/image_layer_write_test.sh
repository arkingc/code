#!/bin/bash

if [ ! -n "$1" ];then
    read -p "input the mode(seqrd,seqwr) you want to test:" mode
else
    mode=$1
fi

docker run -td --name ct1 cow/ssh:1024M1 /bin/bash
docker run -td --name ct2 cow/ssh:1024M2 /bin/bash

docker exec ct1 /etc/init.d/ssh start
docker exec ct2 /etc/init.d/ssh start
echo "root@172.17.0.2" > ip.txt
echo "root@172.17.0.3" >> ip.txt

cache_clear
sleep 5

pssh -h ip.txt -p 2 -i time -p dd if=/dev/zero of=/root/file bs=1M count=1024 

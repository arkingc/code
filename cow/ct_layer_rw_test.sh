#!/bin/bash

if [ ! -n "$1" ];then
    read -p "input the mode(seqrd,seqwr) you want to test:" mode
else
    mode=$1
fi

docker run -td --name ct1 cow/ssh /bin/bash
docker run -td --name ct2 cow/ssh /bin/bash

docker exec ct1 bash -c "cd /root && sysbench --file-num=4 --test=fileio --file-block-size=16K --file-total-size=1G --num-threads=4 prepare"

docker exec ct2 bash -c "cd /root && sysbench --file-num=4 --test=fileio --file-block-size=16K --file-total-size=1G --num-threads=4 prepare"

docker exec ct1 /etc/init.d/ssh start
docker exec ct2 /etc/init.d/ssh start
echo "root@172.17.0.2" > ip.txt
echo "root@172.17.0.3" >> ip.txt

cache_clear
sleep 5

pssh -h ip.txt -p 2 -i time -p sysbench --file-num=4 --test=fileio --file-block-size=16K --file-total-size=1G --num-threads=4 --file-extra-flags=direct --file-fsync-freq=0 --file-test-mode=$mode run

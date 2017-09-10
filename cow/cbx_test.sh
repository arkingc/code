#!/bin/bash

ct_num=2
cow_size="1024M"

for i in $(seq 1 $ct_num)
do
    docker run -td --name ct$i cow/ssh:$cow_size$i /bin/bash
done

sleep 5

sudo dmesg -c >> /dev/null

cache_clear

for j in $(seq 1 $ct_num)
do
    docker exec ct$j bash -c "time dd if=/dev/zero bs=1 count=1 >> /root/file" &
    #docker exec ct$j bash -c "echo $[$(date +%s%N)/1000000]" &
done

wait

sudo dmesg -c > data
cat data

./rm_container.sh $ct_num

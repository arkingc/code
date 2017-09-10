#!/bin/bash

ct_num=5
base_size=32    #MB

for i in $(seq 1 1)
do
    ./run_diff_container.sh $ct_num $base_size
    
    sleep 10

    sudo dmesg -c >> /dev/null

    cache_clear

    pssh -h ip.txt -p $ct_num -i /root/bin/do_cow

    sudo dmesg -c > data
    cat data

    #./rm_container.sh $ct_num
done

#!/bin/bash

if [ ! -n "$1" ];then
    read -p "input the num of ct you want to run:" ct_num
    read -p "input the cow file size(include the unit):" file_size
    read -p "input the times you want to test:" test_time
elif [ ! -n "$2" ];then
    ct_num=$1
    read -p "input the cow file size(include the unit):" file_size
    read -p "input the times you want to test:" test_time
elif [ ! -n "$3" ];then
    ct_num=$1
    file_size=$2
    read -p "input the times you want to test:" test_time
else
    ct_num=$1
    file_size=$2
    test_time=$3 
fi

rm data

for i in $(seq 1 $test_time)
do
    ./run_same_container.sh $ct_num $file_size
    
    sleep 10

    sudo dmesg -c >> /dev/null

    cache_clear

    pssh -h ip.txt -p $ct_num -i /root/bin/do_cow | grep mm #>> data
    
    #echo >> data
    sudo dmesg -c > data
    cat data

    ./awk_20.sh

    ./rm_container.sh $ct_num
done


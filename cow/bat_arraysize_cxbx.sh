#!/bin/bash

if [ ! -n "$1" ];then
    read -p "input the I/O scheduler's name:" scheduler_name
else
    scheduler_name=$1
fi

size_array=("64K" "256K" "1M" "4M" "8M" "16M" "32M" "64M" "128M")
num_array=(60 20 20 10 5 5 3 3)

for i in $(seq 1 1)
do
    declare -i index=$i-1
    file_size=${size_array[$index]}
    ct_num=${num_array[$index]}

    ./bat_ntimes_samesize_difffile.sh $ct_num $file_size 20

    mv result res/result_${file_size}_${ct_num}_zsy_${scheduler_name}_hdd
done

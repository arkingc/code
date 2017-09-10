#!/bin/bash

if [ ! -n "$1" ];then
    read -p "input the number of ct you want to run:" ct_num
    read -p "input the cow file size(include the unit):" file_size
elif [ ! -n "$2" ];then
    ct_num=$1
    read -p "input the cow file size(include the unit):" file_size
else
    ct_num=$1
    file_size=$2
fi

declare -i util=1
util_sector=0.9
util_sector_2=0.75

./n_same_cow.sh 1 $file_size 10

tr_avg_cx=`awk -F 'mm' 'BEGIN{sum=0;count=0} $1!=""{sum+=$1;count++} END{print sum/count}' data`

echo "tr_avg_cx:$tr_avg_cx"

#while true
for i in $(seq 1 3)
do
    ./n_same_cow.sh $ct_num $file_size 10

    tr_avg_bx=`awk -F 'mm' 'BEGIN{sum=0;count=0} $1!=""{sum+=$1;count++} END{print sum/count}' data`

    echo "tr_avg_bx:$tr_avg_bx"

    tmp_util=$(echo $tr_avg_bx $tr_avg_cx $ct_num | awk '{res=$1/$2/$3;print res}')

    echo "tmp_util:$tmp_util"

    j=$(echo "scale=2;$tmp_util>=$util_sector" | bc)

    if [ $j -eq 1 ];then
        util=1
        break
    else
        tmp=$(echo $tmp_util $util | awk '{res=$1/$2;print res}')
        j=$(echo "$tmp<$util_sector_2" | bc)
        
        if [ $j -eq 1 ];then
            ct_num=$(echo "$ct_num*2" | bc)
            continue
        else
            util=$tmp_util
            break
        fi
    fi
done

echo "util:$util"

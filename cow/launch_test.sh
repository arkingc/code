#!/bin/bash
# Program:
#   ###############
# History:
#   ##############

if [ ! -n "$1" ];then
    read -p "please input number of ct you want to launch:" num
else
    num=$1
fi

cache_clear

start_time=`date +%s`

for i in $(seq 1 $num)
do
    docker run -td --name ct$i ubuntu /bin/bash & 
done

wait # wait for all ct

end_time=`date +%s`

run_time=$[ end_time - start_time ]
echo "run time is : $run_time"

./rm_container.sh $num

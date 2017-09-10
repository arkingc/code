#!/bin/bash

if [ ! -n "$1" ];then
    read -p "please input times you want to test:" times
else
    times=$1
fi

for i in $(seq 1 $times)
do
    #docker run -td --rm --name ct cow/ssh:256M1 /bin/bash

    #sleep 5

    cache_clear

    #docker exec ct bash -c "dd if=/dev/zero bs=1 count=1 >> /root/file" & 
    #sleep 0.1 && (time -p docker run -td --rm --name ubuntu ubuntu /bin/bash)>&txt
    (time -p docker run -td --rm --name ubuntu ubuntu /bin/bash)>&txt

    cat txt | grep 'real' >> start_time_result
    
    #sleep 25

    docker stop ubuntu
    #docker stop ct
    
    sleep 2
done

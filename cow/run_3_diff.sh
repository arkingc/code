#!/bin/bash
# Program:
# 	ssss
# History:
# 	ssss
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


for i in $(seq 1 3)
do 
    declare -i ip=$i+1

    if [ $i -eq 1 ];then
        docker run -td --name ct$i -v ~/bin:/root/bin cow/ssh:1024M1 /bin/bash
        echo "root@172.17.0.$ip" > ip.txt  
    elif [ $i -eq 2 ];then
        docker run -td --name ct$i -v ~/bin:/root/bin cow/ssh:256M1 /bin/bash
        echo "root@172.17.0.$ip" >> ip.txt
    else
        docker run -td --name ct$i -v ~/bin:/root/bin cow/ssh:64M1 /bin/bash
        echo "root@172.17.0.$ip" >> ip.txt
    fi
done

for j in $(seq 1 3)
do
    docker exec ct$j /etc/init.d/ssh start
done

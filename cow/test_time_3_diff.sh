
#!/bin/bash
# Program:
# 	ssss
# History:
# 	ssss
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


for j in $(seq 1 1)
do
    ./run_3_diff.sh #启动容器

    sleep 10

    sudo dmesg -c >> /dev/null

    cache_clear

    pssh -h ip.txt -p 3 -i /root/bin/do_cow

    sudo dmesg -c > data
    
    cat data

    ./rm_container.sh 3 #停止、删除容器
done

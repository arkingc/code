
#!/bin/bash
# Program:
# 	ssss
# History:
# 	ssss
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


for j in $(seq 1 20)
do
    ./run_3_diff.sh #启动容器

    ./cache_clear.sh #清缓存

    mussh -m 3 -b -H ip.txt -c "time dd=/dev/zero bs=1 count=1 >> file" | grep real >> result_64M_256M_1G #并行执行cow
        
    echo >> result_64M_256M_1G #每次测试结尾加入一行空行
        
    ./rm_container.sh 3 #停止、删除容器

done

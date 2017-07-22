#!/bin/bash

cat result_64M_256M_1G | awk -F '[ms]' '{print $1 "\t" $2 "\t"}' | \
	awk '{tm = 0} $3!=0{tm = $3 * 60} $4!=0{tm = tm + $4} tm!=0{print tm}' | \
    awk 'BEGIN{ct=0;s1=0;s2=0;s3=0} NR%3==1{ct++;s1+=$1;} NR%3==2{s2+=$1;} NR%3==0{s3+=$1;} \
    ct==20&&NR%3==0{a1=s1/ct;a2=s2/ct;a3=s3/ct;print a1 "\t" a2 "\t" a3;ct=0;s1=0;s2=0;s3=0}'

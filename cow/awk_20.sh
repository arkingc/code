#!/bin/bash

cat data | grep -E "before|after" | awk -F 'after' 'NR==1{print $1} NR!=1&&$2!=""{print $1}' | awk -F "[][]" 'BEGIN{stime=0} NR==1{stime=$2} NR!=1{print $2-stime}'


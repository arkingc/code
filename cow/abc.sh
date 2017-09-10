#!/bin/bash

for i in $(seq 1 30)
do
    sleep 2 &
done

wait

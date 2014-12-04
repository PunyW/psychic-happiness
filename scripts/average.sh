#!/bin/bash
# Count the average of given parameters

sum=0
numargs=$#

for ((i=0 ; i < $numargs ; i++))
do
    let sum+=$1
    shift
done

echo "scale=2; " $sum "/" $numargs | bc

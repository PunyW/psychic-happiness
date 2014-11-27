#!/bin/bash
# Print short cat extending it's stomach of the cat by given parameter

head shortcat.txt
for ((i=0; i<$1; i++))
do
	echo "       |       |"
done
tail shortcat.txt -n 8

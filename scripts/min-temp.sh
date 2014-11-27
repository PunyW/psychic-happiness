#!/bin/bash
# Find daily minimum temp for each date in the given dataset and print daily reports on seperate lines

for folder in $(find $1 -maxdepth 2 -mindepth 2 -type d | sort)
do
	./coldest-day.sh $folder	
done

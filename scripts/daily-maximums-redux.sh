#!/bin/bash
# Find daily maximum temp for each date in the given dataset and print daily reports on seperate lines

for folder in $(find $1 -maxdepth 2 -mindepth 2 -type d | sort)
do
	./hottest-day.sh $folder	
done

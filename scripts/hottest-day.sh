#!/bin/bash
# Find the file that contains maximum processor temp from given path

max_value=0

for file in $(find $@ -name 'hp-temps.txt')
do
	curr_value=$(grep PROCESSOR $file | rev | cut -c 19-20 | rev | sed s/C/\ \/)
	if [ $max_value -lt $curr_value ]; then
		max_value=$curr_value
		filename=$file
	fi
done

echo $filename " " $max_value " °C"

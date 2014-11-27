#!/bin/bash
# Find the file that contains minimum processor temp from given path

min_value=999

for file in $(find $@ -name 'hp-temps.txt')
do
	curr_value=$(grep PROCESSOR $file | rev | cut -c 19-20 | rev | sed s/C/\ \/)
	if [ $min_value -gt $curr_value ]; then
		min_value=$curr_value
		filename=$file
	fi
done

echo $filename " " $min_value " °C"

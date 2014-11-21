#!/bin/bash
# Find the file that contains maximum processor temp from November, 2011

max_value=0

for file in ~/lost24/monitor/2011.11.*/*/hp-temps.txt
do
	curr_value=$(grep PROCESSOR $file | rev | cut -c 19-20 | rev)
	if [ $max_value -lt $curr_value ]; then
		max_value=$curr_value
		filename=$file
	fi
done

echo "Found maximum PROCESSOR_VALUE of " $max_value " in file: " $filename

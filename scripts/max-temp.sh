#!/bin/bash
# Find the file that contains maximum processor temp from given path

max_value=0
min_value=999

while read -r file temp; do
    temp=${temp%%C\/*}
    if [ $max_value -lt $temp ]; then
        max_value=$temp
    	file=${file##$1}
        echo "NEW MAX: " $temp "C " $file
    elif [ $min_value -gt $temp ]; then
        min_value=$temp
	file=${file##$1}
        echo "NEW MIN: " $temp "C " $file
    fi

done < <(find $@ -name hp-temps.txt -exec grep "PROCESSOR_ZONE" {} + | sed -e 's/\/hp-temps.txt:#1//' -e 's/PROCESSOR_ZONE//')

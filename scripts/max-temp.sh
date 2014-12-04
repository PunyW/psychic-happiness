#!/bin/bash
# Find the file that contains maximum processor temp from given path

max_value=0
min_value=999

while read -r file processor temp; do
    file=${file##$1}
    temp=${temp%%C\/*}
    if [ $max_value -lt $temp ]; then
        max_value=$temp
        echo "NEW MAX: " $temp "C " $file
    fi

    if [ $min_value -gt $temp ]; then
        min_value=$temp
        echo "NEW MIN: " $temp "C " $file
    fi

done < <(find $@ -name hp-temps.txt -exec grep "PROCESSOR_ZONE" {} + | sed -e 's/\/hp-temps.txt:#1//g')

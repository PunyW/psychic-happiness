# Week 4

### Longcat

```
head shortcat.txt
for ((i=0; i<$1; i++))
do
        echo "       |       |"
done
tail shortcat.txt -n 8
```

### Daily Maximum
```
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
```

```
puny@puny:~/Documents/linuxFun/psychic-happiness/scripts$ ./hottest-day.sh ~/lost24/monitor/
/home/puny/lost24/monitor/2012.04.25/10:55/hp-temps.txt   54 °C
```

### ...In TSH format
```
#!/bin/bash
# Convert the given line into TSV-format

sed -e 's/lost24//g' -e 's/[a-zA-Z°-]\+//g' -e 's/\/\+//g' -e 's/.\ //'  -e 's/[0-9][0-9]:[0-9][0-9]/\ &\t/g'

```

```
puny@puny:~/Documents/linuxFun/psychic-happiness/scripts$ ./hottest-day.sh ~/lost24/monitor/2011.10.28 | ./in-tsv-format.sh 
2011.10.28 14:10          25
```

### Daily maximums redux

```
#!/bin/bash
# Find daily maximum temp for each date in the given dataset and print daily reports on seperate lines

for folder in $(find $1 -maxdepth 2 -mindepth 2 -type d | sort)
do
        ./hottest-day.sh $folder
done
```
```
puny@puny:~/Documents/linuxFun/psychic-happiness/scripts$ ./daily-maximums-redux.sh ~/lost24/ | ./in-tsv-format.sh 
2011.10.20 14:10          28
2011.10.21 14:25          25
2011.10.22 14:25          28
2011.10.23 21:30          26
2011.10.24 13:45          30
[...]
```
### Fast draws with *GNUPLOT*
![alt text](https://github.com/PunyW/psychic-happiness/blob/master/week-4/max-daily-temps.jpg "Max Temps")

### Winter is coming
```
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
```

### I didn't see that one coming
![alt text](https://github.com/PunyW/psychic-happiness/blob/master/week-4/daily-temps.jpg "Max-Min Temps")

### And that's a wrap
```
#!/bin/bash
unset csv
unset program
unset dirname
print_help() {
        echo "\
Usage: `basename $0` [-t] -c | -w -p dir
Arguments:
        -t      output as tab-separated values
        -c      find the coldest temperature
        -w      find the warmest temperature
        -p dir  search all subdirs of dir"
}

while getopts ":htcwp:" opt; do
        case $opt in
                h)
                        print_help
                        ;;
    p)
      dir=$OPTARG
      ;;
    w)
      hot="./hottest-day.sh"
      ;;    
    c)
      cold="./coldest-day.sh"
      ;;
    t)
      output="./in-tsv-format.sh"
      ;;
        esac
done

if [[ "$output" != "" ]]; then
  $hot $cold $dir | $output
else
  $hot $cold $dir
fi

```

```
puny@puny:~/Documents/linuxFun/psychic-happiness/scripts$ ./find-max-or-min.sh -wtp ~/lost24/monitor/2012.11.22/
2012.11.22 09:25          29  
```

# Week 5

### Counting in your head

```
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
```

### Gone in 60 seconds (aka LOST24-MONITOR-RECAP-MEGAFUN)

```
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
    fi

    if [ $min_value -gt $temp ]; then
        min_value=$temp
        file=${file##$1}
        echo "NEW MIN: " $temp "C " $file
    fi

done < <(find $@ -name hp-temps.txt -exec grep "PROCESSOR_ZONE" {} + | sed -e 's/\/hp-temps.txt:#1//' -e 's/PROCESSOR_ZONE//')
```

```
puny@puny:~/Documents/linuxFun/psychic-happiness/scripts$ time ./max-temp.sh ~/lost24/monitor/
NEW MAX:  32 C  2012.11.14/14:10
NEW MIN:  32 C  2012.11.14/23:25
...
NEW MIN:  7 C  2012.02.02/04:40
NEW MAX:  53 C  2012.04.25/10:35
NEW MAX:  54 C  2012.04.25/10:55

real    0m9.335s
user    0m7.683s
sys     0m5.447s
```

### Hipstafy-Dropbox

```
#!/bin/bash
# Watch hipstafy-dropbox folder for new images, and hipstafy them

while read -r path filename; do
    filename=${filename#* }
    fullname=$path$filename
    result=$(file "$fullname")

    echo "$result" | grep -q "image"
    if [ $? -eq 0 ];then
        cd ~/Desktop/hipstafy-dropbox/hipstafied
        sh ~/scripts/hipstafy.sh $filename
    fi
done < <(inotifywait -m -e moved_to -e create ~/Desktop/hipstafy-dropbox) | sed -e 's/CREATE//g' -e 's/MOVED_TO//g'
```

```
#!/bin/bash
# Hipstafy the given image

file=$*
prefix=${file%.*}
outputfile=$prefix-hipstah.jpg
convert -sepia-tone 60% +polaroid ../"$file" "$outputfile"
```

### The task

```
#!/bin/bash
# Daemon wrapper for hipstafy-wait

daemonname="hipstafy-daemon"
scriptname="hipstafy-wait"
script="hipstafy-wait.sh"
pidfile="/var/run/hipstafy/${scriptname}.pid"
trap "" HUP

do_start() {
    if [ -s $pidfile ]; then
        echo "Already running"
    else
        nohup ./$script >log.out 2> log.err &
        echo $! > $pidfile
        echo "$scriptname started."
    fi
}

do_stop() {
    PID=$(cat $pidfile) 3>&2 2>err-stop.log
    let PID-=1
    kill -term  -$PID 3>&2 2>err-stop.log
    rm -f $pidfile
    echo "Stopped $scriptname"
}

do_status() {
    kill -0 $(cat $pidfile 3>&2 2>/dev/null ) 3>&2 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "Running."
    else
        echo "Not running."
    fi
}

do_restart() {
    echo "Restarting ${scriptname} : "
    do_stop
    sleep 2
    do_start
}

case "$1" in
    start)
        do_start;;
    stop)
        do_stop;;
    status)
        do_status;;
    restart)
        do_restart;;
    *)
        echo "Usage $daemonname {start|stop|status|restart|}"
        exit 3
        ;;
esac
```
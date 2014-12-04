#!/bin/bash
# Watch hipstafy-dropbox folder for new images, and hipstafy them

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




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

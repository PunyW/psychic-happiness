#!/bin/bash
unset csv
unset program
unset dirname
print_help() {
	echo "\
Usage: `basename $0` [-t] -c | -w -p dir
Arguments:
	-t	output as tab-separated values
	-c	find the coldest temperature
	-w	find the warmest temperature
	-p dir	search all subdirs of dir"
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

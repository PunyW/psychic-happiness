#!/bin/bash
# Hipstafy all *.jpg images in the given folder.

for file in $(find $1 -name '*jpg' )
do
	prefix=${file%.jpg}
	outputfile=$prefix-hipstah.jpg
	convert -sepia-tone 60% +polaroid $file $outputfile
done

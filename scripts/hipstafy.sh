#!/bin/bash
# Hipstafy the given image

file=$*
prefix=${file%.*}
outputfile=$prefix-hipstah.jpg
convert -sepia-tone 60% +polaroid ../"$file" "$outputfile"


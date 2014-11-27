#!/bin/bash
# Convert the given line into TSV-format

sed -e 's/lost24//g' -e 's/[a-zA-Z°-]\+//g' -e 's/\/\+//g' -e 's/.\ //'  -e 's/[0-9][0-9]:[0-9][0-9]/\ &\t/g'

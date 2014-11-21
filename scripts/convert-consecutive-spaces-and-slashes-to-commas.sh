#!/bin/bash
# Rewrite consequtive spaces and slashes as commas, for example
# #1        PROCESSOR_ZONE       49C/120F   62C/143F
# #1,PROCESSOR_ZONE,49C,120F,62C,143F,

sed -e 's/\ \+/,/g' -e 's/\/\+/,/g'

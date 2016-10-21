#!/bin/bash

# command-line arguments
rec=$1  # record
per=$2  # period
dt=$3   # offset*100

# force base 10
dt=$((10#$dt))

# call ptsgen
python2 ~/code/ptsgen/ptsgen.py $rec -120000 0 0 -$((dt/100)).$((dt%100)) \
    --scale-interval -${per:0:2}000 -${per:2:4}000 \
    --output ${rec}${per}cool$(printf '%04d' $dt).nc


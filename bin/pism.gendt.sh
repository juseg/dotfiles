#!/bin/bash
# Copyright (c) 2016--2020, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

# Prepare PISM offset time series files

# command-line arguments
rec=$1  # record
per=$2  # period
dt=$3   # offset*100

# force base 10
dt=$((10#$dt))

# call pism-palseries
~/git/code/pism-palseries/pism_palseries.py $rec -120000 0 0 -$((dt/100)).$((dt%100)) \
    --scale-interval -${per:0:2}000 -${per:2:4}000 \
    --output ${rec}.${per}.$(printf '%04d' $dt).nc


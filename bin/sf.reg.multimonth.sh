#!/bin/bash
# Copyright (c) 2021, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Run regional Sentinelflow script in a loop to try and get all images

domain=${1:-greenland}
months=${2:-$(echo {202101..202103})}

for month in $months
do
    echo sf.reg.$domain.sh ${*} --maxrows 99 --daterange ${month}01..${month}31
done

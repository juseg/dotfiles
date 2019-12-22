#!/bin/bash -e

for ifile in $*
do
    ofile=${ifile%.nc}.dev.nc
    ncap2 -s "precipitation=float(precipitation*910.0)" $ifile $ofile
    ncatted -O -a units,precipitation,m,c,"kg m-2 year-1" $ofile
done

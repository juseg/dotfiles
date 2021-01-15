#!/bin/bash
# Copyright (c) 2016--2019, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

# Convert atmosphere files to units needed by PISM >= 1.0

for ifile in $*
do
    ofile=${ifile%.nc}.dev.nc
    ncap2 -s "precipitation=float(precipitation*910.0)" $ifile $ofile
    ncatted -O -a units,precipitation,m,c,"kg m-2 year-1" $ofile
done

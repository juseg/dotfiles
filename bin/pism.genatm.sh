#!/bin/bash
# Copyright (c) 2016--2019, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

# Prepare atmosphere files for PISM < 1.0

# command line arguments
reg=$1 # region
atm=$2 # atmosphere data
res=$3 # resolution
ext=$4 # extrapolation method (nn)

# data subset and location
case $atm in
    cfsr) prefix="cfsr_7910"; loc="world-ll-wgs84";;
    erai) prefix="erai_7912"; loc="world-ll-wgs84";;
    narr) prefix="narr_7900"; loc="northamerica-narr-wgs84";;
    ncar) prefix="ncar_8110"; loc="world-ll-wgs84";;
    wc)   prefix="wc";    loc="world-ll-wgs84";;
esac

# input topo, temperature and precipitation
topo="${atm}_topo"
temp="${prefix}_temp"
prec="${prefix}_prec"

# set region and resolution
g.region region=$reg res=$res

# expand region by half a grid cell
wesn=($(g.region -t | tr '/' ' '))
w=${wesn[0]}
e=${wesn[1]}
s=${wesn[2]}
n=${wesn[3]}
g.region w=$((w-res/2)) e=$((e+res/2)) s=$((s-res/2)) n=$((n+res/2))

# reproject and extrapolate
for map in ${topo} ${temp}{01..12} ${prec}{01..12}; do
    r.proj --overwrite location=$loc input=$map method=bilinear
    [ "$ext" == "nn" ] && ~/git/code/r.interp/r.interp.py \
        input=$map output=$map method="nearest" --o
    [ "$reg" == "arctic" ] && ~/git/code/r.interp/r.interp.py \
        input=$map output=$map method="linear" --o
done

# export PISM file
output=$reg.$atm$ext.${res/%000/k}m.nc
~/git/code/r.out.pism/r.out.pism.py -ep --o edgetemp=315 usurf=$topo \
    air_temp=$(echo ${temp}{01..12} | tr ' ' ',') \
    precipitation=$(echo ${prec}{01..12} | tr ' ' ',') \

# convert to post-PISM 1.0 format
ncap2 -A -s "precipitation=float(precipitation*910.0)" $output
ncatted -O -a units,precipitation,m,c,"kg m-2 year-1" $output

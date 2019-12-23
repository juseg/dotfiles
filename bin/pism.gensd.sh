#!/bin/bash
# Copyright (c) 2016--2019, Julien Seguinot <seguinot@vaw.baug.ethz.ch>
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

# Prepare PISM standard deviation files

# command line arguments
reg=$1 # region
atm=$2 # atmosphere data
res=$3 # resolution

# fixed parameters
noac= # remove annual cycle in SD

# data subset and location
case $atm in
    erai) sd="erai_7912_sd${noac:+_noac}"; loc="world-ll-wgs84";;
    narr) sd="narr_7900_sd${noac:+_noac}"; loc="northamerica-narr-wgs84";;
esac

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
for map in ${sd}{01..12}; do
    r.proj --overwrite location=$loc input=$map method=bilinear
    [ "$ext" == "nn" ] && ~/git/code/r.surf.nearest/r.surf.nearest.py \
        input=$map output=$map --o
    [ "$reg" == "arctic" ] && ~/git/code/r.interp/r.interp.py \
        input=$map output=$map method="linear" --o
done

# export PISM file
~/git/code/r.out.pism/r.out.pism.py --o \
    air_temp_sd=$(echo ${sd}{01..12} | tr ' ' ',') \
    output=$reg.$atm.${res/%000/k}m${noac:+.noac}.nc

#!/bin/bash
# Copyright (c) 2016--2019, Julien Seguinot <seguinot@vaw.baug.ethz.ch>
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

# Prepare PISM bootstrapping files

# command line arguments
reg=$1  # region
srf=$2  # surface topography
res=$3  # resolution
thk=$4  # ice thickness
ghf=$5  # geothermal flux

# fixed parameters
loc="world-ll-wgs84"

# set region and resolution
g.region region=$reg res=$res

# expand region by half a grid cell
wesn=($(g.region -t | tr '/' ' '))
w=${wesn[0]}
e=${wesn[1]}
s=${wesn[2]}
n=${wesn[3]}
g.region w=$((w-res/2)) e=$((e+res/2)) s=$((s-res/2)) n=$((n+res/2))

# reproject topography
if [ "$srf" == "srtm" ]
then
    r.proj --o location=$loc method=bilinear input=${srf}_$reg output=$srf
else
    r.proj --o location=$loc method=bilinear input=$srf
fi

# reproject heat flux
if [ "$ghf" != "" ]
then
    r.proj --o location=$loc method=bilinear input=$ghf
fi

# patch etopo1bed bathymetry
if [ "$srf" != "etopo1bed" ]
then
    r.proj --o location=$loc method=bilinear input=etopo1bed
    r.patch -z --o input=$srf,etopo1bed output=$srf
fi

# to interpolate across the 180 meridian
#~/git/code/r.interp/r.interp.py input=$topo output=$topo method=linear --o
#~/git/code/r.interp/r.interp.py input=$gflx output=$gflx method=linear --o
# to remove Greenland
#r.mapcalc "$topo=if(and(y()>3625000-5./6*x(),y()>1750000),-3000,$topo)"

# in absence of thickness use srf as bedrock topo
if [ "$thk" == "" ]
then
    inputs="bheatflx=$ghf topg=$srf"
else
    inputs="bheatflx=$ghf thk=$thk usurf=$srf"
fi

# export PISM file
python2 ~/git/code/r.out.pism/r.out.pism.py --o $inputs \
    output=$reg.$srf${thk:+.$thk}${ghf:+.$ghf}.${res/%000/k}m.nc

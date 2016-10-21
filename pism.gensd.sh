#!/bin/bash -e

# command line arguments
reg=$1 # region
atm=$2 # atmosphere data
res=$3 # resolution

# additional switch
noac= # remove annual cycle in SD

# data subset and location
case $atm in
    erai) prefix="erai_7912"; loc="world-ll-wgs84";;
    narr) prefix="narr_7900"; loc="northamerica-narr-wgs84";;
esac

# input standard deviation
if [ "$atm" == "narr" ]
then
    sd=${prefix}_sd${noac:+_noac}
else
    sd=erai_7912_sd${noac:+_noac}
fi

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
    [ "$ext" == "nn" ] && ~/code/r.surf.nearest/r.surf.nearest.py \
        input=$map output=$map --o
    [ "$reg" == "arctic" ] && ~/code/r.interp/r.interp.py \
        input=$map output=$map method="linear" --o
done

# export PISM file
~/code/r.out.pism/r.out.pism.py --o \
    air_temp_sd=$(echo ${sd}{01..12} | tr ' ' ',') \
    output=$reg-$atm-${res/%000/k}m${noac:+-noac}.nc

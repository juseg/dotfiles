#!/bin/bash -e

# command line arguments
reg=$1 # region
topo=$2 # topography data
res=$3 # resolution
gflx=$4 # geoflux

# location
case $topo in
    etopo1bed) topomap="etopo1bed"; loc="world-ll-wgs84";;
    etopo1sub) topomap="etopo1bed"; loc="world-ll-wgs84";;
    srtmsub)   topomap="srtm";      loc="world-ll-wgs84";;
    srtm)      topomap="srtm";      loc="world-ll-wgs84";;
    wc)        topomap="wc_topo";   loc="world-ll-wgs84";;
    *)         echo "topo $topo unknown"; exit 2;;
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

# reproject
r.proj location=$loc input=$topomap method=bilinear --o
[ $gflx ] && gflxmap=heatflux_$gflx
[ $gflx ] && r.proj location=$loc input=$gflxmap method=bilinear --o

# arctic maps should be interpolated
if [ "$reg" == "arctic" ]
then
    ~/code/r.interp/r.interp.py input=$topomap output=$topomap method=linear --o
    [ $gflx ] && ~/code/r.interp/r.interp.py input=$gflxmap output=$gflxmap method=linear --o
fi

# remove present glaciers
if [[ "$topo" == *sub ]]
then
    thickmaps=$(g.mlist pattern=thick_????? sep=,)
    r.series input=$thickmaps output=thicksum method=sum --o
    r.mapcalc "$topo=$topomap-if(isnull(thicksum),0,thicksum)"
    topomap=$topo
fi

# export PISM file
python2 ~/code/r.out.pism/r.out.pism.py --o \
    topg=$topomap ${gflx:+bheatflx=heatflux_$gflx} \
    output=$reg-$topo${gflx:++$gflx}-${res/%000/k}m.nc

# remove Greenland
#if [ "$reg" == "laurentide" ] ; then
#	r.mapcalc "$topo=if(and(y()>3625000-5./6*x(),y()>1750000),-3000,$topo)"
#fi

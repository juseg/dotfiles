#!/bin/bash -e

# command line arguments
reg=$1 # region
topo=$2 # topography data
res=$3 # resolution
gflx=$4 # geoflux

# location
case $topo in
    etopo1bed+thk) topomap="etopo1bed"; loc="world-ll-wgs84";;
    etopo1bed) topomap="etopo1bed"; loc="world-ll-wgs84";;
    etopo1sub) topomap="etopo1bed"; loc="world-ll-wgs84";;
    srtm+thk)  topomap="srtm";      loc="world-ll-wgs84";;
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
    ~/git/code/r.interp/r.interp.py input=$topomap output=$topomap method=linear --o
    [ $gflx ] && ~/git/code/r.interp/r.interp.py input=$gflxmap output=$gflxmap method=linear --o
fi

# remove present glaciers
# TODO: resample thickness map before mapcalc for more precision
if [[ "$topo" == *thk || "$topo" == *sub ]]
then
    thickmaps=$(g.list type=rast pattern=thick_????? sep=,)
    r.series input=$thickmaps output=thicksum method=sum --o
    if [[ "$topo" == *sub ]]
    then
        r.mapcalc expression="$topo=$topomap-if(isnull(thicksum),0,thicksum)" --o
        topomap=$topo
    fi
fi

# export PISM file
if [[ "$topo" == *thk ]]
then
    python2 ~/git/code/r.out.pism/r.out.pism.py --o \
        usurf=$topomap ${gflx:+bheatflx=heatflux_$gflx} thk=thicksum \
        output=$reg-$topo${gflx:++$gflx}-${res/%000/k}m.nc
else
    python2 ~/git/code/r.out.pism/r.out.pism.py --o \
        topg=$topomap ${gflx:+bheatflx=heatflux_$gflx} \
        output=$reg-$topo${gflx:++$gflx}-${res/%000/k}m.nc
fi

# remove Greenland
#if [ "$reg" == "laurentide" ] ; then
#	r.mapcalc "$topo=if(and(y()>3625000-5./6*x(),y()>1750000),-3000,$topo)"
#fi

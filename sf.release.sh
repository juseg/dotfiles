#!/bin/bash

# Copy Sentinel-2 composites to webpage
# =====================================

# move to composite images directory
cd $S2/composite

# output directory for the web
webdir=$HOME/public_html/_sentinel2

# for selected regions
for subdir in alps/* greenland/* japan/*
do

    # sync jpegs to webpage
    recent="$(find $subdir -name '*.jp?' | sort | tail -10)"
    mkdir -p $webdir/$subdir
    rsync -t $recent $webdir/$subdir/

    # delete older files
    for f in $webdir/$subdir/*
    do
        echo "$recent" | grep -q ${f##*/} || rm $f
    done

    ## relink latest images
    #latest=$(ls $webdir/$subdir | tail -n 1)
    #ln -sf ${latest%.???}.jpg $webdir/$subdir/latest.jpg
    #ln -sf ${latest%.???}.jpw $webdir/$subdir/latest.jpw

done

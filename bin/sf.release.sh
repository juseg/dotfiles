#!/bin/bash
# Copyright (c) 2016--2019, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

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
    recent="$(find $subdir -name '*.jp?' | sort | tail -20)"
    mkdir -p $webdir/$subdir
    rsync -t $recent $webdir/$subdir/

    # delete older files
    for f in $webdir/$subdir/*
    do
        echo "$recent" | grep -q ${f##*/} || rm $f
    done

done

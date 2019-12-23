#!/bin/bash
# Copyright (c) 2016--2019, Julien Seguinot <seguinot@vaw.baug.ethz.ch>
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

# Copy Sentinel-2 composites to webpage
# =====================================

# move to composite images directory
cd $S2/composite

# output directory for the web
webdir=$HOME/public_html/sentinel

# for selected regions
for subdir in alps/*/* greenland/*/* japan/*/*
do

    # sync jpegs to webpage
    recent=$(find $subdir -name '*.jp?' | sort | tail -10)
    rm -rf $webdir/$subdir
    mkdir -p $webdir/$subdir
    rsync $recent $webdir/$subdir/

    # relink latest images
    latest=$(ls $webdir/$subdir | tail -n 1)
    ln -sf ${latest%.???}.jpg $webdir/$subdir/latest.jpg
    ln -sf ${latest%.???}.jpw $webdir/$subdir/latest.jpw

done

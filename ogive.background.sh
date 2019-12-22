#!/bin/bash

# Create double screen background from Sentinel-2A images

ifile=/scratch_net/ogive/juliens/geodata/satellite/sentinel-2a/composite/\
inglefield/rgb/S2A_20160808_175915_456_RGB.tif
ofile=~/.local/share/backgrounds/inglefield.png

mkdir -p $(dirname $ofile)
convert -crop 4000x1500+0+1000 +repage -resize 3200x1200 \
        -gamma 5.05,5.10,4.85 -sigmoidal-contrast 15,50% \
        -modulate 100,150 $ifile $ofile


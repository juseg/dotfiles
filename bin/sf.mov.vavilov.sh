#!/bin/bash
# Copyright (c) 2018-2021, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Assemble Vavilov Glacier surge animation using Sentinelflow


# Fetch images
# ------------

# change to sentinel2 directory
cd /run/media/julien/archive/geodat/sentinel2/

# Vavilov 40x25 km
sentinelflow.sh $* \
    --intersect 79.3,94.4 --cloudcover 10 --maxrows 99 --tiles 46XEP \
    --extent 510000,8792500,550000,8817500 --name asia/vavilov

# select 24 cloud-free frames for animation
selected="
20160325_073552_458_S2A_RGB.jpg 20160403_080545_455_S2A_RGB.jpg
20160411_072609_890_S2A_RGB.jpg 20160508_071622_464_S2A_RGB.jpg
20170502_074613_462_S2A_RGB.jpg 20180405_070621_464_S2A_RGB.jpg
20180430_075611_459_S2A_RGB.jpg 20180508_080605_458_S2B_RGB.jpg
20180623_082600_463_S2B_RGB.jpg 20180708_082603_458_S2A_RGB.jpg
20180811_080606_460_S2A_RGB.jpg 20180923_072614_458_S2B_RGB.jpg
20190416_081634_542_S2B_RGB.jpg 20190506_081637_104_S2B_RGB.jpg
20190525_075637_019_S2A_RGB.jpg 20190529_082634_799_S2B_RGB.jpg
20190604_075635_957_S2A_RGB.jpg 20190622_080639_557_S2B_RGB.jpg
20190715_081637_795_S2B_RGB.jpg 20190730_081637_891_S2A_RGB.jpg
20190804_081636_665_S2B_RGB.jpg 20190911_082624_636_S2A_RGB.jpg
20190915_080630_499_S2A_RGB.jpg 20190919_083627_026_S2B_RGB.jpg
"

# add text labels using imagemagick
srcdir="composite/asia/vavilov"
prefix="animation/vavilov"

mkdir -p $prefix
for frame in $selected
do
    ifile="$srcdir/$frame"
    ofile="$prefix/$frame"
    label="${frame:0:4}.${frame:4:2}.${frame:6:2}"
    if [ -f $ifile ] && [ ! -f $ofile ]
    then
        convert $ifile -crop 3840x2160+80+170 -resize 1920x1080 +repage \
                -fill '#ffffff80' -draw 'rectangle 40,40,320,120' \
                -font Bitstream-Vera-Sans-Bold -pointsize 36 -gravity northwest \
                -fill black -annotate +60+60 $label \
                -draw "rectangle $((1920-260)),$((1080-65)),$((1920-60)),$((1080-60))" \
                -pointsize 24 -gravity southeast -annotate +60+70 "4 km" $ofile
    fi
done


# Assemble animation
# ------------------

# prepare bumpers
[ -f $prefix.png ] || (cd animation && sf.mov.bumpers.py ${prefix#animation/})

# assembling parametres (depends on frame rate)
fade=12  # number of frames for fade in and fade out effects
hold=25  # number of frames to hold in the beginning and end
secs=$((5+2*hold/25))  # duration of main scene in seconds

# prepare filtergraph for main scene
filt="nullsrc=s=1920x1080:d=$secs[n]"  # create fixed duration stream
filt+=";[0]minterpolate=10:dup"         # duplicate consecutive frames
filt+=",minterpolate=25:blend"          # blend consecutive frames
filt+=",loop=$hold:1:0,[n]overlay"  # hold first frame, delay end

# add title frame and bumpers
filt+=",fade=in:0:$fade,fade=out:$((secs*25-fade)):$fade[main];"  # main scene
filt+="[1]fade=in:0:$fade,fade=out:$((4*25-fade)):$fade[head];"  # title frame
filt+="[2]fade=in:0:$fade,fade=out:$((3*25-fade)):$fade[bysa];"  # license
filt+="[head][main][bysa]concat=3" \

# mp4 video
ffmpeg -pattern_type glob -r 5 -i "$prefix/*.jpg" \
    -loop 1 -t 2 -i ${prefix}.png \
    -loop 1 -t 2 -i animation/ccbysa.png \
    -filter_complex $filt \
    -pix_fmt yuv420p -c:v libx264 $prefix.mp4

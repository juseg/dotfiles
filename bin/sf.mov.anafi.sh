#!/bin/bash
# Copyright (c) 2020-2021, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Assemble Anafi Island seasons animation using Sentinelflow

# Fetch images
# ------------

# change to sentinel2 directory
cd /run/media/julien/archive/geodat/sentinel2/

# Anafi 30x15 km
sentinelflow.sh ${*:---offline} \
    --intersect 36.4,25.8 --cloudcover 10 --tiles 35SLA \
    --daterange 20200101..20210101 --maxrows 99 \
    --extent 376000,4015000,406000,4035000 --name europe/anafi

# select 30 cloud-free frames for animation
selected="
20191209_091015_658_S2A_RGB.jpg 20200123_091011_820_S2B_RGB.jpg
20200313_091016_894_S2B_RGB.jpg 20200318_091015_199_S2A_RGB.jpg
20200412_091015_037_S2B_RGB.jpg 20200417_091018_948_S2A_RGB.jpg
20200611_091021_224_S2B_RGB.jpg 20200616_091024_992_S2A_RGB.jpg
20200621_091021_448_S2B_RGB.jpg 20200701_091021_221_S2B_RGB.jpg
20200706_091023_345_S2A_RGB.jpg 20200711_091020_597_S2B_RGB.jpg
20200716_091023_651_S2A_RGB.jpg 20200721_091020_721_S2B_RGB.jpg
20200726_091024_465_S2A_RGB.jpg 20200731_091021_697_S2B_RGB.jpg
20200805_091024_866_S2A_RGB.jpg 20200810_091022_279_S2B_RGB.jpg
20200815_091024_778_S2A_RGB.jpg 20200820_091022_435_S2B_RGB.jpg
20200825_091024_295_S2A_RGB.jpg 20200830_091022_138_S2B_RGB.jpg
20200904_091023_400_S2A_RGB.jpg 20200909_091021_409_S2B_RGB.jpg
20200914_091023_079_S2A_RGB.jpg 20200929_091021_940_S2B_RGB.jpg
20201004_091024_695_S2A_RGB.jpg 20201108_091020_594_S2B_RGB.jpg
20201113_091022_587_S2A_RGB.jpg 20201128_091018_666_S2B_RGB.jpg
"

# add text labels using imagemagick
srcdir="composite/europe/anafi"
prefix="animation/anafi"
mkdir -p $prefix
for frame in $selected
do
    ifile="$srcdir/$frame"
    ofile="$prefix/$frame"
    label="${frame:0:4}.${frame:4:2}.${frame:6:2}"
    if [ -f $ifile ] && [ ! -f $ofile ]
    then
        convert $ifile -crop 1920x1080+540+360 -resize 1920x1080 +repage \
                -fill '#ffffff80' -draw 'rectangle 40,40,320,120' \
                -font Bitstream-Vera-Sans-Bold -pointsize 36 -gravity northwest \
                -fill black -annotate +60+60 $label -fill white \
                -draw "rectangle $((1920-260)),$((1080-65)),$((1920-60)),$((1080-60))" \
                -pointsize 24 -gravity southeast -annotate +60+70 "2 km" $ofile
    fi
done


# Assemble animation
# ------------------

# prepare bumpers
[ -f $prefix.png ] || (cd animation && sf.mov.bumpers.py ${prefix#animation/})

# assembling parametres (depends on frame rate)
fade=12  # number of frames for fade in and fade out effects
hold=25  # number of frames to hold in the beginning and end
secs=$((18+2*hold/25))  # duration of main scene in seconds

# prepare filtergraph for main scene
filt="nullsrc=s=1920x1080:d=$secs[n]"  # create fixed duration stream
filt+=";[0]minterpolate=10:dup"        # duplicate consecutive frames
filt+=",minterpolate=25:blend"         # blend consecutive frames
filt+=",loop=$hold:1:0,[n]overlay"     # hold first frame, delay end

# add title frame and bumpers
filt+=",fade=in:0:$fade,fade=out:$((secs*25-fade)):$fade[main];"  # main scene
filt+="[1]fade=in:0:$fade,fade=out:$((4*25-fade)):$fade[head];"  # title frame
filt+="[2]fade=in:0:$fade,fade=out:$((3*25-fade)):$fade[bysa];"  # license
filt+="[head][main][bysa]concat=3" \

# mp4 video
ffmpeg -pattern_type glob -r 5 -loop 1 -t 18 -i "$prefix/*.jpg" \
    -loop 1 -t 2 -i ${prefix}.png \
    -loop 1 -t 2 -i animation/ccbysa.png \
    -filter_complex $filt \
    -pix_fmt yuv420p -c:v libx264 $prefix.mp4

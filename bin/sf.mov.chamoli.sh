#!/bin/bash
# Copyright (c) 2021, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Assemble Chamali slide development animation using Sentinelflow

# Fetch images
# ------------

# change to sentinel2 directory
cd /run/media/julien/archive/geodat/sentinel2/

# Chamoli 30x15 km
sentinelflow.sh ${*:---offline} \
    --intersect 30.4,79.7 --maxrows 20 --tiles 44RLU \
    --extent 360000,3355000,390000,3375000 \
    --name asia/chamoli

# select 24 cloud-free frames for animation
selected="
20200913_053034_359_S2B_RGB.jpg 20200918_053036_920_S2A_RGB.jpg
20200928_053037_771_S2A_RGB.jpg 20201008_053035_565_S2A_RGB.jpg
20201013_053035_984_S2B_RGB.jpg 20201018_053037_869_S2A_RGB.jpg
20201023_053035_753_S2B_RGB.jpg 20201028_053037_493_S2A_RGB.jpg
20201107_053036_766_S2A_RGB.jpg 20201112_053033_224_S2B_RGB.jpg
20201117_053035_316_S2A_RGB.jpg 20201122_053032_687_S2B_RGB.jpg
20201127_053033_067_S2A_RGB.jpg 20201202_053031_418_S2B_RGB.jpg
20201207_053029_902_S2A_RGB.jpg 20201217_053030_134_S2A_RGB.jpg
20201227_053031_851_S2A_RGB.jpg 20210101_053030_584_S2B_RGB.jpg
20210111_053031_674_S2B_RGB.jpg 20210116_053033_117_S2A_RGB.jpg
20210121_053032_118_S2B_RGB.jpg 20210126_053032_780_S2A_RGB.jpg
20210131_053031_939_S2B_RGB.jpg 20210205_053031_766_S2A_RGB.jpg
"

# add text labels using imagemagick
srcdir="composite/asia/chamoli"
prefix="animation/chamoli"
mkdir -p $prefix
for frame in $selected
do
    ifile="$srcdir/$frame"
    ofile="$prefix/$frame"
    label="${frame:0:4}.${frame:4:2}.${frame:6:2}"
    if [ -f $ifile ] && [ ! -f $ofile ]
    then
        convert $ifile -crop 960x540+1320+980 -resize 1920x1080 +repage \
                -fill '#ffffff80' -draw 'rectangle 40,40,320,120' \
                -font Bitstream-Vera-Sans-Bold -pointsize 36 -gravity northwest \
                -fill black -annotate +60+60 $label -fill black \
                -draw "rectangle $((1920-260)),$((1080-65)),$((1920-60)),$((1080-60))" \
                -pointsize 24 -gravity southeast -annotate +60+70 "1 km" $ofile
    fi
done

# add red circle on last image
if [ -f ${ofile%.jpg}_bis.jpg ]
then
    convert $ofile -fill none -stroke 'black' -strokewidth 5 \
            -draw 'circle 980,780 1100,790' ${ofile%.jpg}_bis.jpg
fi

# Assemble animation
# ------------------

# prepare bumpers
[ -f $prefix.png ] || (cd animation && sf.mov.bumpers.py ${prefix#animation/})

# assembling parametres (depends on frame rate)
fade=12  # number of frames for fade in and fade out effects
hold=25  # number of frames to hold in the beginning and end
secs=$((12+2*hold/25))  # duration of main scene in seconds

# prepare filtergraph for main scene
# (it seems necessary to triplicate last frame before interp)
filt="[0]tpad=0:2:clone:clone"          # clone last frame (for interp)
filt+=",minterpolate=4:dup:scd=none"    # duplicate consecutive frames
filt+=",minterpolate=25:blend:scd=none" # blend consecutive frames
filt+=",tpad=$hold:$hold:clone:clone"   # clone first and last frames

# add title frame and bumpers
filt+=",fade=in:0:$fade,fade=out:$((secs*25-fade)):$fade[main];"  # main scene
filt+="[1]fade=in:0:$fade,fade=out:$((4*25-fade)):$fade[head];"  # title frame
filt+="[2]fade=in:0:$fade,fade=out:$((3*25-fade)):$fade[bysa];"  # license
filt+="[head][main][bysa]concat=3" \

# mp4 video
ffmpeg -pattern_type glob -r 2 -i "$prefix/*.jpg" \
    -loop 1 -t 2 -i ${prefix}.png \
    -loop 1 -t 2 -i animation/ccbysa.png \
    -filter_complex $filt \
    -pix_fmt yuv420p -c:v libx264 $prefix.mp4

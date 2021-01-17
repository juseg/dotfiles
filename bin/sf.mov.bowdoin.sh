#!/bin/bash
# Copyright (c) 2016-2021, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Assemble Bowdoin Glacier summer melt animation using Sentinelflow

# Fetch images
# ------------

# change to sentinel2 directory
cd /run/media/julien/archive/geodat/sentinel2/

# Qaanaaq 60x60 km (this is done by sf.regions.sh)
# sentinelflow.sh $*
#     --intersect 77.7,-68.5 --tiles 19XDG,19XEG \
#     --extent 465000,8595000,525000,8655000 --name greenland/qaanaaq

# select 42 cloud-free frames for animation
selected="
20160318_175038_458_S2A_RGB.jpg 20160321_180021_460_S2A_RGB.jpg
20160324_181004_462_S2A_RGB.jpg 20160325_174028_749_S2A_RGB.jpg
20160327_181959_462_S2A_RGB.jpg 20160328_175044_578_S2A_RGB.jpg
20160403_180957_459_S2A_RGB.jpg 20160406_181959_460_S2A_RGB.jpg
20160407_174950_459_S2A_RGB.jpg 20160410_180125_659_S2A_RGB.jpg
20160414_173948_462_S2A_RGB.jpg 20160417_174954_463_S2A_RGB.jpg
20160424_174125_261_S2A_RGB.jpg 20160504_173947_147_S2A_RGB.jpg
20160506_181935_287_S2A_RGB.jpg 20160503_180920_455_S2A_RGB.jpg
20160504_173947_147_S2A_RGB.jpg 20160506_181935_287_S2A_RGB.jpg
20160507_174912_457_S2A_RGB.jpg 20160509_182933_282_S2A_RGB.jpg
20160517_174913_462_S2A_RGB.jpg 20160523_180922_457_S2A_RGB.jpg
20160524_173944_536_S2A_RGB.jpg 20160605_181924_458_S2A_RGB.jpg
20160615_181922_460_S2A_RGB.jpg 20160618_182919_461_S2A_RGB.jpg
20160628_182918_458_S2A_RGB.jpg 20160706_174910_456_S2A_RGB.jpg
20160708_182920_459_S2A_RGB.jpg 20160712_180919_461_S2A_RGB.jpg
20160713_174015_006_S2A_RGB.jpg 20160715_181924_456_S2A_RGB.jpg
20160723_173907_455_S2A_RGB.jpg 20160729_175916_460_S2A_RGB.jpg
20160730_172902_461_S2A_RGB.jpg 20160808_175915_456_S2A_RGB.jpg
20160809_172902_463_S2A_RGB.jpg 20160815_174910_462_S2A_RGB.jpg
20160910_181050_650_S2A_RGB.jpg 20160913_181945_463_S2A_RGB.jpg
20160918_172958_464_S2A_RGB.jpg 20160923_182055_459_S2A_RGB.jpg
"

# other usable images with small issues
# 20160322_173001_458_S2A_RGB.jpg  # slight overcast
# 20160421_172942_462_S2A_RGB.jpg  # small clouds
# 20160516_181926_455_S2A_RGB.jpg  # slight overcast
# 20160521_172904_459_S2A_RGB.jpg  # small clouds
# 20160529_182922_461_S2A_RGB.jpg  # small clouds
# 20160612_180919_456_S2A_RGB.jpg  # small clouds
# 20160626_174908_464_S2A_RGB.jpg  # small clouds
# 20160722_181050_652_S2A_RGB.jpg  # small clouds
# 20160825_174913_066_S2A_RGB.jpg  # overcast
# 20160829_172859_459_S2A_RGB.jpg  # large clouds
# 20160917_180022_497_S2A_RGB.jpg  # small clouds

# add text labels using imagemagick
srcdir="composite/greenland/qaanaaq"
prefix="animation/bowdoin"

mkdir -p $prefix
for frame in $selected
do
    ifile="$srcdir/$frame"
    ofile="$prefix/$frame"
    label="${frame:0:4}.${frame:4:2}.${frame:6:2}"
    credit="CC BY-SA 4.0 J. Seguinot (2020). \
Contains modified Copernicus Sentinel data. Processed with SentinelFlow."
    if [ -f $ifile ] && [ ! -f $ofile ]
    then
        convert $ifile -crop 2880x1620+3060+2740 -resize 1920x1080 +repage \
                -fill '#ffffff80' -draw 'rectangle 40,40,320,120' \
                -font Bitstream-Vera-Sans-Bold -pointsize 36 -gravity northwest \
                -fill black -annotate +60+60 $label \
                -draw "rectangle $((1920-260)),$((1080-65)),$((1920-60)),$((1080-60))" \
                -pointsize 24 -gravity southeast -annotate +60+70 "3 km" $ofile
#                -fill '#ffffff80' -draw 'rectangle 0,1032,1920,1080' \
#                -font Bitstream-Vera-Sans -pointsize 24 -gravity southeast \
#                -fill black -annotate +8+8 "$credit" $ofile
    fi
done


# Assemble animation
# ------------------

# prepare bumpers
[ -f $prefix.png ] || sf.mov.bumpers.py ${prefix#animation/}

# assembling parametres (depends on frame rate)
fade=12  # number of frames for fade in and fade out effects
hold=25  # number of frames to hold in the beginning and end
secs=$((8+2*hold/25))  # duration of main scene in seconds

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
    -loop 1 -t 2 -i animation/bysa.png \
    -filter_complex $filt \
    -pix_fmt yuv420p -c:v libx264 $prefix.mp4

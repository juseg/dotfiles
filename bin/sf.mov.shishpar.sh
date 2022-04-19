#!/bin/bash
# Copyright (c) 2020-2022, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Assemble Shishpar Glacier surge animation using Sentinelflow
#
#    ./shishpar.sh --user USER --pass PASS
#    ./shishpar.sh --offline


# Fetch images
# ------------

# Shishpar 960x640 @10m
sentinelflow.sh $* \
    --intersect 36.4,74.6 --cloudcover 90 --maxrows 99 \
    --tiles 43SDA --extent 457200,4020800,466800,4027200 --name shishpar

# Select 32 cloud-free images
selected="
20180710_055841_016_S2A_RGB.jpg 20180715_054701_712_S2B_RGB.jpg
20180725_054747_616_S2B_RGB.jpg 20180804_055505_763_S2B_RGB.jpg
20180814_054632_458_S2B_RGB.jpg 20180824_054745_219_S2B_RGB.jpg
20180829_055429_075_S2A_RGB.jpg 20180908_055844_232_S2A_RGB.jpg
20180913_055808_367_S2B_RGB.jpg 20180918_055436_905_S2A_RGB.jpg
20181023_055118_552_S2B_RGB.jpg 20181028_055809_977_S2A_RGB.jpg
20181107_055850_500_S2A_RGB.jpg 20181117_055848_889_S2A_RGB.jpg
20181202_055850_324_S2B_RGB.jpg 20181207_055846_600_S2A_RGB.jpg
20190401_055857_355_S2B_RGB.jpg 20190421_055901_323_S2B_RGB.jpg
20190531_055903_306_S2B_RGB.jpg 20190705_055859_928_S2A_RGB.jpg
20190720_055903_627_S2B_RGB.jpg 20190725_055859_928_S2A_RGB.jpg
20190804_055859_347_S2A_RGB.jpg 20190918_055854_067_S2B_RGB.jpg
20190923_055855_437_S2A_RGB.jpg 20190928_055855_177_S2B_RGB.jpg
20191013_055857_853_S2A_RGB.jpg 20191202_055853_608_S2A_RGB.jpg
20191207_055849_051_S2B_RGB.jpg 20191217_055849_711_S2B_RGB.jpg
20191227_055850_061_S2B_RGB.jpg 20200116_055849_059_S2B_RGB.jpg
"

# add text labels using Imagemagick
mkdir -p animation/shishpar
for frame in $selected
do
    ifile="composite/shishpar/$frame"
    ofile="animation/shishpar/$frame"
    label="${frame:0:4}.${frame:4:2}.${frame:6:2}"
    credit="CC BY-SA 4.0 J. Seguinot (2020). \
Contains modified Copernicus Sentinel data. Processed with SentinelFlow."
    if [ -f $ifile ] && [ ! -f $ofile ]
    then
        convert $ifile -crop 720x480+120+160 +repage \
                -fill '#ffffff80' -draw 'rectangle 24,24,192,68' \
                -font Bitstream-Vera-Sans-Bold -pointsize 24 -gravity northwest \
                -fill black -annotate +32+32 $label \
                -fill '#ffffff80' -draw 'rectangle 0,456,720,480' \
                -font Bitstream-Vera-Sans -pointsize 12 -gravity southeast \
                -fill black -annotate +4+4 "$credit" $ofile
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

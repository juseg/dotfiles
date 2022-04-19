#!/bin/bash
# Copyright (c) 2018--2022, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Assemble Kiruna Sentinel-2 animation using Sentinelflow
#
#    ./anim_kiruna.sh --user USER --pass PASS
#    ./anim_kiruna.sh --offline
#
# Three years of mining and moving in Kiruna https://vimeo.com/304078839
#
# Kiruna, the most arctic city of Sweden, also hosts the world's largest iron
# ore mine. In the last few years, the city has begun a major relocation plan
# to allow for further mining under the current city centre, located right in
# the alignment of the main vein in the top-centre of the image. Thousands of
# homes, historical buildings and the major transportation axes will all be
# moved a few kilometers east.
#
# The images show mining activity in some of the pits, construction of new
# roads and foundations of the new city centre (centre-right). The new city
# hall opened last week and is visible a circular building at the southern edge
# of the construction site. Also note how the heat from the mine appears to
# accelerate snow melt in the Spring as compared to the surrounding areas. In
# the coming years Sentinel satellites will certainly capture the more dramatic
# changes planned for Kiruna.
#
# Contains Copernicus Sentinel data (2015--2018). Processed with Sentinelflow:
#
#    sentinelflow.sh [...] --intersect 67.9,20.2 --cloudcover 30 --maxrows 99 \
#                          --tiles 34WDA --extent 458400,7519600,477600,7530400


# Fetch images
# ------------

# pass command-line arguments to sentinelflow
sf="../sentinelflow.sh $*"

# Kiruna 1920x1080 @10m
$sf --name kiruna \
    --intersect 67.9,20.2 --cloudcover 30 --maxrows 99 \
    --tiles 34WDA --extent 458400,7519600,477600,7530400

# select 48 cloud-free frames for animation
selected="
20150816_102023_459_S2A_RGB.jpg 20150822_104035_460_S2A_RGB.jpg
20150911_104038_457_S2A_RGB.jpg 20160402_102020_459_S2A_RGB.jpg
20160418_104023_463_S2A_RGB.jpg 20160428_104026_460_S2A_RGB.jpg
20160508_104027_456_S2A_RGB.jpg 20160816_104025_461_S2A_RGB.jpg
20160905_104021_462_S2A_RGB.jpg 20161019_102031_459_S2A_RGB.jpg
20170304_104015_464_S2A_RGB.jpg 20170324_104016_456_S2A_RGB.jpg
20170417_102023_460_S2A_RGB.jpg 20170503_104024_458_S2A_RGB.jpg
20170523_104025_461_S2A_RGB.jpg 20170612_104023_458_S2A_RGB.jpg
20170706_102022_460_S2A_RGB.jpg 20170711_102023_463_S2B_RGB.jpg
20170905_104015_460_S2B_RGB.jpg 20170907_103021_455_S2A_RGB.jpg
20170927_103018_458_S2A_RGB.jpg 20170930_104019_460_S2A_RGB.jpg
20171020_104048_464_S2A_RGB.jpg 20171029_102121_463_S2B_RGB.jpg
20180219_103046_462_S2B_RGB.jpg 20180221_102033_460_S2A_RGB.jpg
20180222_104035_067_S2B_RGB.jpg 20180224_103018_463_S2A_RGB.jpg
20180314_104014_461_S2B_RGB.jpg 20180316_103018_462_S2A_RGB.jpg
20180318_102016_461_S2B_RGB.jpg 20180323_102021_456_S2A_RGB.jpg
20180417_102021_457_S2B_RGB.jpg 20180418_104023_461_S2A_RGB.jpg
20180508_104025_460_S2A_RGB.jpg 20180510_103020_459_S2B_RGB.jpg
20180517_102021_457_S2B_RGB.jpg 20180525_103024_462_S2A_RGB.jpg
20180617_104021_457_S2A_RGB.jpg 20180701_102024_461_S2A_RGB.jpg
20180702_104021_464_S2B_RGB.jpg 20180712_104020_461_S2B_RGB.jpg
20180716_102021_464_S2B_RGB.jpg 20180729_103019_462_S2B_RGB.jpg
20180909_102020_462_S2A_RGB.jpg 20181009_102020_464_S2A_RGB.jpg
20181010_104018_457_S2B_RGB.jpg 20181024_102102_462_S2B_RGB.jpg"

# add text labels using Imagemagick
mkdir -p animation/kiruna
for frame in $selected
do
    ifile="composite/kiruna/$frame"
    ofile="animation/kiruna/$frame"
    label="${frame:0:4}.${frame:4:2}.${frame:6:2}"
    if [ ! -f $ofile ]
    then
        convert $ifile -fill '#ffffff80' -draw 'rectangle 1600,40,1880,120' \
                -font DejaVu-Sans-Bold -pointsize 36 -gravity northeast \
                -fill black -annotate +65+60 $label $ofile
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

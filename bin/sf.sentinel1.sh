#!/bin/bash
# Copyright (c) 2020, Julien Seguinot <seguinot@vaw.baug.ethz.ch>
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

# Retrieve Sentinel-1 images on Qaanaaq region
# ============================================
# 
# Usage:
#
#     sf.sentinel1.sh -u user -p pass
#     sf.sentinel1.sh -


# move to base directory
cd $S1

# download online (recent) images intersecting Bowdoin front with sentinelflow
# this will work after the rolling start date stated in:
# https://scihub.copernicus.eu/userguide/LongTermArchive
sentinelflow.sh $* --sentinel1 --intersect 77.7,-68.6

# order offline (archived) products with Copernicus dhusget script
# https://scihub.copernicus.eu/twiki/pub/SciHubUserGuide/BatchScripting/dhusget.sh
if [ "$*" != "--offline" ]
then
    query='platformname:Sentinel-1'
    query+=' AND producttype:GRD'
    query+=' AND polarisationmode:HH HV'
    query+=' AND sensoroperationalmode:IW'
    query+=' AND footprint:"intersects(77.7,-68.6)"'
    query+=' AND beginPosition:[2017-01-01T00:00:00.000Z TO 2018-01-01T00:00:00.000Z]'
    ./dhusget.sh $* -F "$query" -l 100 -P 1 -o all -W 0
fi

# inflate HH polarisation images from products downloaded with dhusget
for filename in PRODUCT/*.zip
do
    [ -s $filename ] && unzip -jn $filename '*/measurement/*hh*.tiff' -d measurement/
done
chmod +r measurement/*.tiff

# adjust brightness and contrast and crop to jpg with imagemagick
im="convert -flop -gamma 9.0 -sigmoidal-contrast 25,50% -quality 95"
for filename in measurement/*.tiff
do
    basename=$(basename ${filename%.tiff})
    [ -f developed/inglefield/$basename.jpg ] ||
        $im -crop 16000x8000+2000+8000 $filename developed/inglefield/$basename.jpg
    [ -f developed/qaanaaq/$basename.jpg ] ||
        $im -crop 6000x6000+5000+10000 $filename developed/qaanaaq/$basename.jpg
    [ -f developed/preview/$basename.jpg ] ||
        $im -resize 10% $filename developed/preview/$basename.jpg
done

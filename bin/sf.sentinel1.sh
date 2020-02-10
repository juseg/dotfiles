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

# reprojected with gdal and convert to jpg with imagemagick
mkdir -p projected/{inglefield,qaanaaq}
for ifile in measurement/*.tiff
do

    # Inglefield region (same as I use for Sentinel-2)
    ofile="projected/inglefield/$(basename ${ifile%.tiff})"
    if [ ! -f $ofile.jpg ]
    then
        gdalwarp -r cubic -t_srs "+proj=utm +zone=19" \
                 -te 405000 8535000 605000 8685000 -tr 10 10 \
                 $ifile $ofile.tif
        convert -gamma 9.0 -sigmoidal-contrast 25,50% -quality 95 \
                $ofile.{tif,jpg}
        # rm $ofile.tif
    fi

    # Qaanaaq region (same as I use for Sentinel-2)
    ofile="projected/qaanaaq/$(basename ${ifile%.tiff})"
    if [ ! -f $ofile.jpg ]
    then
        gdalwarp -r cubic -t_srs "+proj=utm +zone=19" \
                 -te 465000 8595000 525000 8655000 -tr 10 10 \
                 -overwrite $ifile $ofile.tif
        convert -gamma 9.0 -sigmoidal-contrast 25,50% -quality 95 \
                $ofile.{tif,jpg}
        # rm $ofile.tif
    fi
done

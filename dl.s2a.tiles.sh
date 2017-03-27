#!/bin/bash

# Run sentinelflow.sh to prepare tile previews
# ============================================

## Bash command line to list downloaded tiles
# ls granules/ | cut -d '_' -f 10 | sort | uniq -c

# move to base directory
cd $SCRATCH2/geodata/satellite/sentinel-2a

# path to executable
sf="$HOME/code/sentinelflow/sentinelflow.sh\
 --user julien.seguinot --pass Cordillera\
 --resolution 50 --nullvalues 100 $*"

# directories for patching
prevdir=composite/previews
tiledir=composite/tiles
args="--basedir $basedir $*"


# Alps
# ----

## Tiling
# 32TLT, 32TMT, 32TNT, 32TPT
# 32TLS, 32TMS, 32TNS, 32TPS
# 32TLR, 32TMR, 32TNR, 32TPR

## Python code to compute intersects
# import numpy as np
# import cartopy.crs as ccrs
# utm = ccrs.UTM(32)
# ll = ccrs.PlateCarree()
# x = np.arange(350e3, 751e3, 100e3)
# y = np.arange(5250e3, 5049e3, -100e3)
# yy, xx = np.meshgrid(y, x)
# pts = ll.transform_points(utm, xx, yy)
# for c in pts:
#   for l in c:
#       print '--intersect "%02.8f,%02.8f"' % (l[1], l[0])

$sf --tiles 32TLT --name tiles/t32tlt-biel \
    --intersect 47.38622257,07.01258040 \
    --extent 300000,5200000,400000,5300000
$sf --tiles 32TLS --name tiles/t32tls-lausanne \
    --intersect 46.48686923,07.04559256 \
    --extent 300000,5100000,400000,5200000
$sf --tiles 32TLR --name tiles/t32tlr-aoste \
    --intersect 45.58735656,07.07706153 \
    --extent 300000,5000000,400000,5100000

$sf --tiles 32TMT --name tiles/t32tmt-zurich \
    --intersect 47.40153812,08.33734451 \
    --extent 400000,5200000,500000,5300000
$sf --tiles 32TMS --name tiles/t32tms-brig \
    --intersect 46.50171334,08.34835925 \
    --extent 400000,5100000,500000,5200000
$sf --tiles 32TMR --name tiles/t32tmr-novare \
    --intersect 45.60174443,08.35885873 \
    --extent 400000,5000000,500000,5100000

$sf --tiles 32TNT --name tiles/t32tnt-stgallen \
    --intersect 47.40153812,09.66265549 \
    --extent 500000,5200000,600000,5300000
$sf --tiles 32TNS --name tiles/t32tns-stmoritz \
    --intersect 46.50171334,09.65164075 \
    --extent 500000,5100000,600000,5200000
$sf --tiles 32TNR --name tiles/t32tnr-milano \
    --intersect 45.60174443,09.64114127 \
    --extent 500000,5000000,600000,5100000

$sf --tiles 32TPT --name tiles/t32tpt-innsbruck \
    --intersect 47.38622257,10.98741960 \
    --extent 600000,5200000,700000,5300000
$sf --tiles 32TPS --name tiles/t32tps-bolzano \
    --intersect 46.48686923,10.95440744 \
    --extent 600000,5100000,700000,5200000
$sf --tiles 32TPR --name tiles/t32tpr-bergame \
    --intersect 45.58735656,10.92293847 \
    --extent 600000,5000000,700000,5100000

# --tiles 32TQT --intersect 47.35562341,12.31054590
# --tiles 32TQS --intersect 46.45721117,12.25563221
# --tiles 32TQR --intersect 45.55860936,12.20328196

mkdir -p $prevdir/alps/{rgb,irg}
find $tiledir/t32*/rgb -name "*.jpg" -printf "%f\n" | cut -d '_' -f 2-4 |
    sort | uniq | while read date
    do
        for col in rgb irg
        do
            scene="$col/S2A_${date}_${col^^}"
            ofile="$prevdir/alps/$scene"
            if [ ! -s $ofile.jpg ]
            then
                echo "Mosaicing alps/$scene.tif ..."
                gdalbuildvrt -quiet -te 300000 5000000 600000 5300000 \
                    $ofile.vrt $tiledir/t32*/$scene.tif
                gdal_translate -quiet -co photometric=rgb $ofile.vrt $ofile.tif
                convert -gamma 5.05,5.10,4.85 -sigmoidal-contrast 15,50% \
                        -modulate 100,150 -quality 85 -quiet \
                        $ofile.tif $ofile.jpg
                rm $ofile.vrt $ofile.tif
            fi
        done
    done


# Inglefield
# ----------

## Tiling
# 19XDG, 19XEG
# 19XDF, 19XEF

## Python code to compute intersects
# import numpy as np
# import cartopy.crs as ccrs
# utm = ccrs.UTM(19)
# ll = ccrs.PlateCarree()
# x = np.arange(450e3, 551e3, 100e3)
# y = np.arange(8650e3, 8549e3, -100e3)
# yy, xx = np.meshgrid(y, x)
# pts = ll.transform_points(utm, xx, yy)
# for c in pts:
#   for l in c:
#       print '--intersect "%02.8f,%02.8f"' % (l[1], l[0])

$sf --tiles 19XDG --name tiles/t19xdg-siorapaluk \
    --intersect "77.91682084,-71.14010792" \
    --extent 400000,8600000,500000,8700000
$sf --tiles 19XDF --name tiles/t19xdf-natsilivik \
    --intersect "77.02131528,-70.99470679" \
    --extent 400000,8500000,500000,8600000

$sf --tiles 19XEG --name tiles/t19xeg-qeqertat \
    --intersect "77.91682084,-66.85989208" \
    --extent 500000,8600000,600000,8700000
$sf --tiles 19XEF --name tiles/t19xef-qaqqarsuaq \
    --intersect "77.02131528,-67.00529321" \
    --extent 500000,8500000,600000,8600000

mkdir -p $prevdir/inglefield/{rgb,irg}
find $tiledir/t19*/rgb -name "*.jpg" -printf "%f\n" | cut -d '_' -f 2-4 |
    sort | uniq | while read date
    do
        for col in rgb irg
        do
            scene="$col/S2A_${date}_${col^^}"
            ofile="$prevdir/inglefield/$scene"
            if [ ! -s $ofile.jpg ]
            then
                echo "Mosaicing inglefield/$scene.tif ..."
                gdalbuildvrt -quiet -te 400000 8500000 600000 8700000 \
                    $ofile.vrt $tiledir/t19*/$scene.tif
                gdal_translate -quiet -co photometric=rgb $ofile.vrt $ofile.tif
                convert -gamma 5.05,5.10,4.85 -sigmoidal-contrast 15,50% \
                        -modulate 100,150 -quality 85 -quiet \
                        $ofile.tif $ofile.jpg
                rm $ofile.vrt $ofile.tif
            fi
        done
    done

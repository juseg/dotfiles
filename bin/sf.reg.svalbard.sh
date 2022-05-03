#!/bin/bash
# Copyright (c) 2016-2021, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Assemble Svalbard regional Sentinel-2 images using Sentinelflow.
#
# This was meant to follow along the Climate Sentinels expedition, but I never
# finished it due to the Japan stuff.

# change to sentinel2 directory
cd /run/media/julien/archive/geodat/sentinel2/

# South Spitsberg overview 210x310 km
# NOTE: there is a clear image on March 17th, partly clear one on 26th.
sentinelflow.sh ${*:---offline} \
    --daterange 20210326..20210430 \
    --intersect 12,77,18,79 --tiles $(echo 33X{V,W}{F,G,H} | tr ' ' ',') \
    --extent 400000,8490000,610000,8800000 --nullvalues 100 \
    --resolution 100 --name svalbard/spitsbergen

# Some points on the preliminary route
# Ny-Ålesund        --intersect 78.92,11.93
# Kongsvegspasset   --intersect 78.73,13.43
# Ekmansfjorden     --intersect 78.66,14.60
# Dicksonsfjorden   --intersect 78.65,15.34
# Pyramiden         --intersect 78.65,16.33
# Tempelfjorden     --intersect 78.38,16.93
# Gruvfonna         --intersect 77.99,16.74
# Sveabukta         --intersect 77.82,16.33
# Bamsebo           --intersect 77.55,15.06
# Horsund           --intersect 77.00,15.55

# Ny-Ålesund 60x40 km (offline)
sentinelflow.sh ${*:-} --offline \
    --intersect 78.9,11.9 --tiles 33XVH \
    --extent 415000,8735000,475000,8775000 --name svalbard/nyaalesund

# Kongsvegen 60x40 km (offline)
sentinelflow.sh ${*:-} --offline \
    --intersect 78.7,13.4 --tiles 33XVH \
    --extent 440000,8720000,500000,8760000 --name svalbard/kongsvegen

# Trebrevatnet 60x40 km (offline)
sentinelflow.sh ${*:-} --offline \
    --intersect 78.8,14.4 --tiles 33XVH,33XWH \
    --extent 470000,8720000,530000,8760000 --name svalbard/trebrevatnet

# Pyramiden 60x40 km
sentinelflow.sh ${*:-} --offline \
    --intersect 78.7,14.7 --tiles 33XVH,33XWH \
    --extent 480000,8705000,540000,8745000 --name svalbard/pyramiden

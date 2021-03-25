#!/bin/bash
# Copyright (c) 2016-2021, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Assemble Greenland regional Sentinel-2 images using Sentinelflow

# change to sentinel2 directory
cd /run/media/julien/archive/geodat/sentinel2/


# Inglefield
# ----------

# Inglefield Bay 200x150 km
sentinelflow.sh ${*:---offline} \
    --intersect -70.0,77.0,-67.5,78.0 --tiles 19XDF,19XDG,19XEF,19XEG \
    --maxrows 40 --extent 405000,8535000,605000,8685000 \
    --name greenland/inglefield

# Qaanaaq 60x60 km (intersect on Bowdoin Glacier)
sentinelflow.sh ${*:-} \
    --intersect 77.7,-68.5 --tiles 19XDG,19XEG --offline \
    --extent 465000,8595000,525000,8655000 --name greenland/qaanaaq


# Ilulissat
# ---------

# Eqip Sermia 90x40 km
sentinelflow.sh ${*:---offline} \
    --intersect 69.8,-50.2 --tiles 22WEC \
    --extent 500000,7720000,590000,7760000
    --name greenland/eqip \

# Ilulissat 120x50 km
sentinelflow.sh ${*:---offline} \
    --intersect 69.1,-50.9 --tiles 22WDB,22WEB --maxrows 20 \
    --extent 480000,7650000,600000,7700000 --name greenland/ilulissat \

#!/bin/bash
# Copyright (c) 2022, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Get last images of Norway subregions using Sentinelflow

# change to sentinel2 directory
# (temporary local directory)
cd ~/data/sentinel2

# Bergen 60x40 km (intersect on four tiles)
sentinelflow.sh ${*:---offline} \
    --name norway/bergen \
    --intersect 60.3,5.4 --tiles 32VKM,32VKN,32VLM,32VLN \
    --extent 270000,6680000,330000,6720000

# Folgefønna 60x40 km
sentinelflow.sh ${*:---offline} \
    --name norway/folgefonna \
    --intersect 60.0,6.3 --tiles 32VLM \
    --extent 320000,6640000,380000,6680000

# Hordaland 210x140 km (offline)
sentinelflow.sh ${*:-} --offline \
    --name norway/hordaland \
    --intersect 60.3,5.4 --tiles 32VKM,32VKN,32VLM,32VLN \
    --nullvalues 100 \
    --extent 200000,6630000,410000,6770000

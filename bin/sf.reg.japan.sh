#!/bin/bash
# Copyright (c) 2022, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Get last images of several Japan subregions  using Sentinelflow

# change to sentinel2 directory
cd /run/media/julien/archive/geodat/sentinel2/

# Sapporo 120x100 km
sentinelflow.sh ${*:---offline} \
    --name japan/sapporo \
    --intersect 42.8,141.1 --tiles 54TVN,54TWN --maxrows 20 \
    --extent 440000,4700000,560000,4800000

# Akan-Mashu 70x100 km
sentinelflow.sh ${*:---offline} \
    --name japan/akanmashu \
    --intersect 44.0,144.3 --tiles 54TYP --cloudcover 30 \
    --extent 737500,4800000,807500,4900000

# Daisetsu 30x50 km
sentinelflow.sh ${*:---offline} \
    --name japan/daisetsu \
    --intersect 43.7,142.8 --tiles 54TXP \
    --extent 630000,4800000,660000,4850000

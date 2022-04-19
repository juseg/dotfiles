#!/bin/bash
# Copyright (c) 2016-2021, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Assemble Greenland regional Sentinel-2 images using Sentinelflow

# change to sentinel2 directory
cd /run/media/julien/archive/geodat/sentinel2/


# Inglefield Land
# ---------------

# Inglefield Land East 60x40 km (intersect on four tiles)
sentinelflow.sh ${*:-} --offline \
    --intersect 78.3,-68.8 --tiles 19XDG,19XDH,19XEG,19XEH \
    --extent 495000,8687500,555000,8727500 --name greenland/inglefield-land-east

# Inglefield Land West 60x40 km (intersect on both tiles, offline)
sentinelflow.sh ${*:---offline} \
    --intersect 78.3,-70.4 --tiles 19XDG,19XDH \
    --extent 445000,8680000,505000,8720000 --name greenland/inglefield-land-west

# Hiawatha Glacier 60x40 km (offline)
sentinelflow.sh ${*:-} --offline \
    --intersect 78.8,-66.9 --tiles 19XEH \
    --extent 520000,8725000,580000,8765000 --name greenland/hiawatha-glacier


# Inglefield Gulf
# ---------------

# Cape Alexander 60x40 km
sentinelflow.sh ${*:---offline} \
    --intersect 78.2,-73.0 --tiles 19XDG \
    --extent 400000,8645000,460000,8685000 --name greenland/cape-alexander

# Siorapaluk 60x40 km
sentinelflow.sh ${*:---offline} \
    --intersect 78.8,-70.6 --tiles 19XDG \
    --extent 435000,8625000,495000,8665000 --name greenland/siorapaluk

# Qeqertat 60x40 km
sentinelflow.sh ${*:---offline} \
    --intersect 77.6,-66.3 --tiles 19XEG \
    --extent 540000,8595000,600000,8635000 --name greenland/qeqertat

# Qaanaaq 90x60 km
sentinelflow.sh ${*:---offline} \
    --intersect 77.7,-68.8 --tiles 19XDG,19XEG \
    --extent 450000,8595000,540000,8655000 --name greenland/qaanaaq-90x60

# Kiatak Island 60x40 km
sentinelflow.sh ${*:---offline} \
    --intersect 77.4,-72.0 --tiles 19XDF,19XDG \
    --extent 400000,8570000,460000,8610000 --name greenland/kiatak-island

# Itivdleq 60x40 km
sentinelflow.sh ${*:---offline} \
    --intersect 77.2,-69.7 --tiles 19XDF,19XDG \
    --extent 445000,8560000,505000,8600000 --name greenland/itivdleq

# Olrik Fjord 60x40 km
sentinelflow.sh ${*:---offline} \
    --intersect 77.1,-67.5 --tiles 19XEF \
    --extent 530000,8545000,590000,8585000 --name greenland/olrik-fjord

# Inglefield Gulf 210x140 km (offline)
sentinelflow.sh ${*:-} --offline \
    --intersect -70,77,-67.5,78 --tiles 19XDF,19XDG,19XEF,19XEG \
    --nullvalues 100 --resolution 100 \
    --extent 400000,8535000,610000,8675000 --name greenland/inglefield-gulf

# Inglefield Bay 200x150 km (offline)
sentinelflow.sh ${*:-} --offline \
    --intersect -70,77,-67.5,78 --tiles 19XDF,19XDG,19XEF,19XEG \
    --extent 405000,8535000,605000,8685000 --name greenland/inglefield-200x150

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

#!/bin/bash
# Copyright (c) 2016--2019, Julien Seguinot <seguinot@vaw.baug.ethz.ch>
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

# Run sentinelflow.sh on multiple regions
# =======================================

# move to base directory
cd $S2

# path to executable
sf="$HOME/git/code/sentinelflow/sentinelflow.sh $*"


# Alps
# ----

# Ecrins 30x30 km
$sf --name alps/ecrins \
    --intersect 44.9,6.3 --tiles 31TGK \
    --extent 745000,4965000,775000,4995000 --resolution 10

# Alps 400x300 km
$sf --name alps/alps --nullvalues 100 \
    --intersect 7.5,45.5,11.5,47.5 --maxrows 100 \
    --tiles $(echo 32T{L,M,N,P}{R,S,T} | tr ' ' ',') \
    --extent 300000,5000000,700000,5300000 --resolution 100

# Mt Blanc 40x55 km
$sf --name alps/mtblanc --offline --tiles 32TLR,32TLS \
    --extent 315000,5065000,355000,5120000 --resolution 10

# Valais 135x95 km
$sf --name alps/valais --offline --tiles 32TLR,32TLS,32TMR,32TMS \
    --extent 325000,5080000,460000,5175000 --resolution 10

# Glarus 100x85 km
$sf --name alps/glarus --offline --tiles 32TMS,32TMT,32TNS,32TNT \
    --extent 445000,5155000,545000,5240000 --resolution 10

# Ticino 80x90 km
$sf --name alps/ticino --offline --tiles 32TMR,32TMS,32TNR,32TNS \
    --extent 455000,5070000,535000,5160000 --resolution 10

# Grisons 85x100 km
$sf --name alps/grisons --offline --tiles 32TNS,32TNT,32TPS,32TPT \
    --extent 530000,5115000,615000,5215000 --resolution 10


# Greenland
# ---------

# Inglefield Bay 200x150 km
$sf --name greenland/inglefield \
    --intersect -70.0,77.0,-67.5,78.0 --maxrows 40 \
    --tiles 19XDF,19XDG,19XEF,19XEG \
    --extent 405000,8535000,605000,8685000 --resolution 10

# Qaanaaq 60x60 km (intersect on Bowdoin Glacier)
$sf --name greenland/qaanaaq --offline \
    --intersect 77.7,-68.5 --tiles 19XDG,19XEG \
    --extent 465000,8595000,525000,8655000 --resolution 10

# Eqip Sermia 90x40 km
$sf --name greenland/eqip \
    --intersect 69.8,-50.2 --tiles 22WEC \
    --extent 500000,7720000,590000,7760000 --resolution 10

# Ilulissat 120x50 km
$sf --name greenland/ilulissat \
    --intersect 69.1,-50.9 --tiles 22WDB,22WEB --maxrows 20 \
    --extent 480000,7650000,600000,7700000 --resolution 10


# Japan
# -----

# Sapporo 120x100 km
$sf --name japan/sapporo \
    --intersect 42.8,141.1 --tiles 54TVN,54TWN --maxrows 20 \
    --extent 440000,4700000,560000,4800000

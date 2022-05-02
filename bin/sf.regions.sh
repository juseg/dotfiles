#!/bin/bash
# Copyright (c) 2016--2019, Julien Seguinot (juseg.github.io)
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

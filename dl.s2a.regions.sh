#!/bin/bash

# Run parent script dl.s2a.sh on multiple regions
# ===============================================

args="$*"

# Greenland
# ---------

# Qaanaaq 6000x6000 (intersect on Bowdoin Glacier)
dl.s2a.sh --name "greenland/qaanaaq" \
          --intersect "77.7,-68.5" --tiles "19XDG,19XEG" \
          --extent "465000,8595000,525000,8655000" --resolution "10" $args

# Qeqertaq / Tracy 4000x6000
dl.s2a.sh --name "greenland/qeqertat" \
          --intersect "77.5,-66.7" --tiles "19XEG" \
          --extent "535000,8595000,595000,8635000" --resolution "10" $args

# Inglefield 4000x4000 (intersect on Bowdoin Glacier)
dl.s2a.sh --name "greenland/inglefield" \
          --intersect "77.7,-68.5" --tiles "19XDF,19XEF,19XDG,19XEG" \
          --extent "400000,8500000,600000,8700000" --resolution "50" $args

# Hans Tausen Ice Cap 8000x8000 + 5000x8000
dl.s2a.sh --name "greenland/hanstausen-utm23" \
          --intersect "82.6,-38.2" --tiles "23XNN,23XNM" --cloudcover "30" \
          --extent "529800,9130000,609800,9210000" --resolution "10" $args
dl.s2a.sh --name "greenland/hanstausen-utm24" \
          --intersect "82.6,-38.2" --tiles "24XWT,24XWS" --cloudcover "30" \
          --extent "500000,9120000,550000,9200000" --resolution "10" $args

# Europe
# ------

# Ecrins 3000x3000
dl.s2a.sh --name "europe/ecrins" \
          --intersect "44.9,6.3" --tiles "31TGK" \
          --extent "745000,4965000,775000,4995000" --resolution "10" $args

# Mt Blanc 3000x3000
dl.s2a.sh --name "europe/mtblanc" \
          --intersect "45.9,7.0" --tiles "32TLR" \
          --extent "325000,5070000,355000,5100000" --resolution "10" $args

# Plaine Morte 1000x1000
dl.s2a.sh --name "europe/plainemorte" \
          --intersect "46.4,7.5" --tiles "32TLS" \
          --extent "380000,5135000,390000,5145000" --resolution "10" $args

# Bern / Aletsch 6000x4000
dl.s2a.sh --name "europe/bern" \
          --intersect "46.5,8.1" --tiles "32TMS" \
          --extent "400000,5135000,460000,5175000" --resolution "10" $args

# Uri 3000x5000
dl.s2a.sh --name "europe/uri" \
          --intersect "46.8,8.4" --tiles "32TMT,32TMS" \
          --extent "445000,5155000,475000,5205000" --resolution "10" $args

# Appenzell 4000x3000
dl.s2a.sh --name "europe/appenzell" \
          --intersect "47.2,9.3" --tiles "32TNT" \
          --extent "500000,5210000,540000,5240000" --resolution "10" $args

# Bernina 4000x3000
dl.s2a.sh --name "europe/bernina" \
          --intersect "46.4,9.9" --tiles "32TNS" \
          --extent "540000,5120000,580000,5150000" --resolution "10" $args

# Pennine / Gorner 6000x4000
dl.s2a.sh --name "europe/pennine" \
          --intersect "46.0,7.8" --tiles "32TLS,32TMS,32TLR,32TMR" \
          --extent "360000,5080000,420000,5125000" --resolution "10" $args

# Glarus 6000x6000 (intersect on Clariden)
dl.s2a.sh --name "europe/glarus" \
          --intersect "46.8,8.9" --tiles "32TMT,32TMS,32TNT,32TNS" \
          --extent "475000,5170000,535000,5230000" --resolution "10" $args

# Oetztal 4000x3000 (move 5 km to the north into 32TPT)
dl.s2a.sh --name "europe/otztal" \
          --intersect "46.8,10.9" --tiles "32TPT,32TPS" \
          --extent "625000,5175000,665000,5205000" --resolution "10" $args

# Ortler 3000x3000
dl.s2a.sh --name "europe/ortler" \
          --intersect "46.5,10.6" --tiles "32TPS" \
          --extent "605000,5130000,635000,5160000" --resolution "10" $args

# Adamello 3000x2000
dl.s2a.sh --name "europe/adamello" \
          --intersect "46.2,10.6" --tiles "32TPS" \
          --extent "605000,5105000,635000,5125000" --resolution "10" $args

# Asia
# ----

# Aru Co 2000x2000
dl.s2a.sh --name "asia/aruco" \
          --intersect "34.0,82.3" --tiles "44SPC" \
          --extent "605000,3755000,625000,3775000" --resolution "10" $args

# Haizishan 8000x10000
dl.s2a.sh --name "asia/haizishan" \
          --intersect "29.3,100.2" --tiles "47RNN,47RPN" --cloudcover "30" \
          --extent "585000,3200000,665000,3300000" --resolution "10" $args

# Hanoi 3000x3000
dl.s2a.sh --name "asia/hanoi" \
          --intersect "21.0,105.8" --tiles "48QWJ" --cloudcover "30" \
          --extent "570000,2310000,600000,2340000" --resolution "10" $args

# Vitim 4000x2000
dl.s2a.sh --name "asia/vitim" \
          --intersect "57.4,116.5" --tiles "50VMJ,50VNJ" --cloudcover "30" \
          --extent "400000,6300000,600000,6400000" --resolution "50" $args

# America
# -------

# Tuya 3000x3000
dl.s2a.sh --name "america/tuya" \
          --intersect "59.1,-130.6" --tiles "09VUF,09VVF" --cloudcover "30" \
          --extent "395000,6530000,425000,6560000" --resolution "10" $args


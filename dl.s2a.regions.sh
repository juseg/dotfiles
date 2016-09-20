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


# Inglefield 4000x4000 (intersect on Bowdoin Glacier)
dl.s2a.sh --name "greenland/inglefield" \
          --intersect "77.7,-68.5" --tiles "19XDF,19XEF,19XDG,19XEG" \
          --extent "400000,8500000,600000,8700000" --resolution "50" $args

# Asia
# ----

# Haizishan 4000x2000
dl.s2a.sh --name "asia/haizishan" \
          --intersect "29.3,100.0" --tiles "47RNN,47RPN" --cloudcover "30" \
          --extent "500000,3200000,700000,3300000" --resolution "50" $args

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


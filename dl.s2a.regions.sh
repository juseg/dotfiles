#!/bin/bash

# Run parent script dl.s2a.sh on multiple regions
# ===============================================

# Qaanaaq 6000x6000
dl.s2a.sh --name "qaanaaq" --tiles "T19XDG,T19XEG" \
          --extent "465000 8595000 525000 8655000" --resolution "10"

# Inglefield 4192x2192
dl.s2a.sh --name "inglefield" --tiles "T19XDG,T19XEG" \
          --extent "400000 8590400 609600 8700000" --resolution "50" -o

# Inglefield 2000x2000
#dl.s2a.sh --name "inglefield" --tiles "T19XDF,T19XEF,T19XDG,T19XEG" \
#          --extent "400000 8500000 600000 8700000" --resolution "100"

# FIXME: implement maximum cloud cover filter

# Haizishan 2000x1000
#dl.s2a.sh --name "haizishan" --tiles "47RNN,47RPN" \
# --extent "500000 3200000 700000 3300000" --resolution "100"

# Hanoi 1000x1000
#dl.s2a.sh --name "hanoi" --tiles "48QWJ" \
# --extent "500000 2300000 600000 2400000" --resolution "100"

# Vitim 1000x1000
#dl.s2a.sh --name "vitim" --tiles "50VMJ" \
# --extent "400000 6300000 500000 6400000" --resolution "100"

# Tuya 1000x1000
#dl.s2a.sh --name "tuya" --tiles "09VVF" \
# --extent "400000 6500000 500000 6600000" --resolution "100"

#!/bin/bash

# Run parent script dl.s2a.sh on multiple regions
# ===============================================

# Qaanaaq 6000x6000
dl.s2a.sh --name "qaanaaq" \
          --intersect "77.7,-68.5" --tiles "T19XDG,T19XEG" \
          --extent "465000,8595000,525000,8655000" --resolution "10"

# Inglefield 4192x2192
dl.s2a.sh --name "inglefield" \
          --intersect "77.7,-68.5" --tiles "T19XDG,T19XEG" \
          --extent "400000,8590400,609600,8700000" --resolution "50" -o

# Inglefield 4000x4000
#dl.s2a.sh --name "inglefield" \
#          --intersect "77.7,-68.5" --tiles "T19XDF,T19XEF,T19XDG,T19XEG" \
#          --extent "400000,8500000,600000,8700000" --resolution "50"

# Haizishan 4000x2000
#dl.s2a.sh --name "haizishan" \
#          --intersect "29.3,100.0" --tiles "47RNN,47RPN" --cloudcover "20" \
#          --extent "500000,3200000,700000,3300000" --resolution "50"

# Hanoi 2000x2000
#dl.s2a.sh --name "hanoi" \
#          --intersect "21.0,105.8" --tiles "48QWJ" --cloudcover "20" \
#          --extent "500000,2300000,600000,2400000" --resolution "50"

# Vitim 2000x2000
#dl.s2a.sh --name "vitim" \
#          --intersect "" --tiles "50VMJ" --cloudcover "20" \
#          --extent "400000,6300000,500000,6400000" --resolution "50"

# Tuya 2000x2000
#dl.s2a.sh --name "tuya" \
#          --intersect "59.1,-130.6" --tiles "09VVF" --cloudcover "20" \
#          --extent "400000,6500000,500000,6600000" --resolution "50"

#!/bin/bash

# push Sentinel-2 composite images to Hokkaido Bowdoin server
orig=/scratch_net/ogive/juliens/geodata/satellite/sentinel-2a/composite/
dest=hokudai:Documents/2016/sentinel-2a/
rsync -vahP --delete --delete-excluded --exclude=*.{tif,txt} \
    $orig/{inglefield,qaanaaq} $dest


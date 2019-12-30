#!/bin/bash
# Copyright (c) 2019, Julien Seguinot <seguinot@vaw.baug.ethz.ch>
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

# Convert all variables in NetCDF file to Geotiff

# parse input file
ifile=$1

# convert all non-coordinate subdatasets
# (convert a single variable: gdal_translate NETCDF:"$ifile":$var $ifile.$var.tif)
gdalinfo $ifile | grep NETCDF | cut -d '=' -f 2 | egrep -v '(lat|lon|time_bounds)' |
    while read sub ; do gdal_translate $sub ${ifile%.nc}.${sub##*:}.tif
done

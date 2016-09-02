#!/bin/bash

rsync -vazhP --delete ~/pism/input dora:pism/

# * extract from rsync help
#    -v, --verbose               increase verbosity
#    -a, --archive               archive mode; same as -rlptgoD (no -H)
#    -z, --compress              compress file data during the transfer
#    -h, --human-readable        output numbers in a human-readable format
#        --partial               keep partially transferred files
#        --progress              show progress during transfer
#    -P                          same as --partial --progress
#        --delete                delete extraneous files from destination dirs
#        --force                 force deletion of directories even if not empty
# * implied by the archive mode:
#    -r, --recursive             recurse into directories
#    -k, --copy-dirlinks         transform symlink to dir into referent dir
#    -K, --keep-dirlinks         treat symlinked dir on receiver as dir
#    -l, --links                 copy symlinks as symlinks
#    -p, --perms                 preserve permissions
#    -t, --times                 preserve times
#    -g, --group                 preserve group
#    -o, --owner                 preserve owner (super-user only)
#        --devices               preserve device files (super-user only)
#        --specials              preserve special files
#    -D                          same as --devices --specials


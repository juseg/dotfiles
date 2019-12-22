# Backup to USB drive

rsync -vahP --delete /run/media/julien/archive/ /run/media/julien/backup \
    --exclude=.Trash*

# Extract from rsync help
# * options activated
#  -v, --verbose               increase verbosity
#  -a, --archive               archive mode; same as -rlptgoD (no -H)
#  -h, --human-readable        output numbers in a human-readable format
#    --partial               keep partially transferred files
#    --progress              show progress during transfer
#  -P                          same as --partial --progress
#    --delete                delete extraneous files from destination dirs
#    --force                 force deletion of directories even if not empty
# * implied by the archive mode:
#  -r, --recursive             recurse into directories
#  -l, --links                 copy symlinks as symlinks
#  -p, --perms                 preserve permissions
#  -t, --times                 preserve times
#  -g, --group                 preserve group
#  -o, --owner                 preserve owner (super-user only)
#    --devices               preserve device files (super-user only)
#    --specials              preserve special files
#  -D                          same as --devices --specials
# * options not activated
#  -k, --copy-dirlinks         transform symlink to dir into referent dir
#  -K, --keep-dirlinks         treat symlinked dir on receiver as dir
#  -L, --copy-links            transform symlink into referent file/dir
#  -u, --update                skip files that are newer on the receiver
#  -b, --backup                make backups (see --suffix & --backup-dir)
#    --backup-dir=DIR        make backups into hierarchy based in DIR
#    --suffix=SUFFIX         backup suffix (default ~ w/o --backup-dir)
#  -z, --compress              compress file data during the transfer


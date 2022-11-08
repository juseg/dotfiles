# Copyright (c) 2019-2022, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# Link these dotfiles in user home directory

# make any missing parent directory
mkdir -p ~/.ssh

# link directories
for path in .config .ssh/config
do
    [ -e ~/$path ] || ln --symbolic $PWD/$path ~/$path
    [ -h ~/$path ] || echo "$path exists and is not a link"
done

# copy relative links
cp --no-clobber --no-dereference .{x,z}profile ~/

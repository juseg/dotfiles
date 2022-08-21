# Copyright (c) 2019-2022, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

# Update dotfile links

mkdir -p ~/.config/git
mkdir -p ~/.ssh

for path in .bash_aliases  .config/git/config .config/nvim .ssh/config .vim
do
    if [ ! -e ~/$path ]  # file does not exists
    then
        ln -s $PWD/$path ~/$path
    elif [ ! -h ~/$path ]  # file is not a link
    then
        echo "$path exists and is not a link"
    fi
done

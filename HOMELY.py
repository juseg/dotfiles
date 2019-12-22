# Copyright (c) 2019, Julien Seguinot <seguinot@vaw.baug.ethz.ch>
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

"""Automate dotfile installation with Homely."""

import homely.files

homely.files.mkdir('~/.config')
homely.files.mkdir('~/.config/git')
homely.files.mkdir('~/.vim')
homely.files.mkdir('~/.ssh')

homely.files.symlink('.config/git/config', '.config/git/config')
homely.files.symlink('.ssh/config', '.ssh/config')
homely.files.symlink('.vim/vimrc', '.vim/vimrc')

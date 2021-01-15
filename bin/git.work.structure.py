#!/usr/bin/env python
# Copyright (c) 2016--2019, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

"""Check work repositories directory structure."""

import os


def main():
    """Main program called during execution."""

    # compulsory and optional files
    gitroot = os.path.expanduser('~/git/work')
    required = ('LICENSE.rst', 'README.rst')
    optional = ('.git', 'articles', 'data', 'figures', 'movies', 'proposals',
                'references')

    # for each repository
    for repo in os.listdir(gitroot):

        # check for required files
        for filename in required:
            filepath = os.path.join(repo, filename)
            if not os.path.isfile(filepath):
                print("missing file " + filepath)

        # check for conformal structure
        for filename in os.listdir(os.path.join(gitroot, repo)):
            filepath = os.path.join(repo, filename)
            if os.path.isdir(os.path.join(gitroot, filepath)) and \
                    filename not in required + optional:
                print("unexpected file " + filepath)


if __name__ == '__main__':
    main()

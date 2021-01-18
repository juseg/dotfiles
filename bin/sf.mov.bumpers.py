#!/usr/bin/env python
# Copyright (c) 2021, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

"""Assemble bumbers for Sentinelflow animation."""

import os.path
import argparse
import subprocess
import requests
import matplotlib.pyplot as plt


METADATA = {
    'Titles': {'anafi':     "Anafi Island through the seasons",
               'bowdoin':   "Bowdoin Glacier flow and summer melt season",
               'vavilov':   "Vavilov Glacier surge and ice cap collapse"},
    'Author': "J. Seguinot, 2021",
    'Credit': ("Contains modified Copernicus Sentinel data. "
               "Processed with Sentinelflow."),
    'License text': "This work is licensed under",
    'License link': "http://creativecommons.org/licenses/by-sa/4.0/"}


def bumper_init():
    """Init figure and axes for animation bumper."""
    fig = plt.figure(figsize=(192.0/25.4, 108.0/25.4))
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_facecolor('k')
    ax.set_xlim(-96, 96)
    ax.set_ylim(-54, 54)
    return fig, ax


def bumper_main(prefix):
    """Prepare title animation bumper."""

    # initialize figure
    fig, ax = bumper_init()

    # draw text
    ax.text(0, 24, METADATA['Titles'][prefix], color='1.0', fontsize=18,
            ha='center', va='center', linespacing=1.5)
    ax.text(0, 4, METADATA['Author'], ha='center', va='center', linespacing=3)
    ax.text(-80, -40, METADATA['Credit'], linespacing=1.5)

    # save
    fig.savefig(prefix+'.png')
    plt.close(fig)


def bumper_bysa():
    """Prepare CC-BY-SA animation bumper."""

    # initialize figure
    fig, ax = bumper_init()

    # create icons directory if missing
    if not os.path.isdir('icons'):
        os.mkdir('icons')

    # retrieve icons if missing
    for icon in ['cc', 'by', 'sa']:
        url = 'https://mirrors.creativecommons.org/presskit/icons/'+icon+'.svg'
        pngpath = 'icons/' + icon + '.png'
        svgpath = 'icons/' + icon + '.svg'
        if not os.path.isfile('icons/{}.svg'.format(icon)):
            text = requests.get(url).text
            text = text.replace('FFFFFF', '000000')
            text = text.replace('path', 'path fill="#bfbfbf"')
            with open(svgpath, 'w') as svgfile:
                svgfile.write(text)

        # prepare cc icon bitmaps
        cmd = 'inkscape {} -w 640 -h 640 --export-filename={}'
        if not os.path.isfile(pngpath):
            subprocess.call(cmd.format(svgpath, pngpath).split(' '))

    # add cc icons
    ax.imshow(plt.imread('icons/cc.png'), extent=[-56, -24, -4, 28])
    ax.imshow(plt.imread('icons/by.png'), extent=[-16, +16, -4, 28])
    ax.imshow(plt.imread('icons/sa.png'), extent=[+24, +56, -4, 28])

    # draw text
    ax.text(0, -20, 'This work is licensed under', ha='center')
    ax.text(0, -32, METADATA['License link'], ha='center',
            weight='bold', family=['DeJaVu Sans'])

    # save
    fig.savefig('ccbysa.png')
    plt.close(fig)


def main():
    """Main program for command-line execution."""

    # parse arguments
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('prefix', help='animation prefix')
    args = parser.parse_args()

    # set default font properties
    plt.rc('axes', grid=False)
    plt.rc('figure', dpi=254)
    plt.rc('font', size=12)
    plt.rc('text', color='0.75')

    # assemble bumpers
    bumper_main(args.prefix)
    bumper_bysa()


if __name__ == '__main__':
    main()

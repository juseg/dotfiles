# Copyright (c) 2013-2021, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)

# Bash aliases
# ============

# Unix commands
# -------------

# cd aliases
alias ..='cd ..'

# du aliases
alias da='du -had1 . | sed -e "s:./::"'
alias ds='du -had1 . | sed -e "s:./::" | sort -h'

# ls aliases
alias ls='ls --color=auto --human-readable'
alias la='ls --almost-all'
alias ll='ls -l'
alias lal='la -l'
alias lt='ll -rt'
alias lat='la -rt'
alias l='ls -F'

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# other aliases
alias whoruns='ps aux | cut -d " " -f 1 | sed "1 d" | sort | uniq'
alias oftused='cat ~/.bash_history | sort | uniq -c | sort -h'
alias rmemail='sed -i "1,5 s/<.*seg.*@.*>/(juseg.github.io)/g"'

# Installed commands
# ------------------

# imagemagick aliases
alias 1920p='convert -resize 1920x1920 -quality 95'
alias 3840p='convert -resize 3840x3840 -quality 95'
alias sfcredit='convert -gravity center -crop 2:1 +repage -resize 960x480 -fill "#ffffff80" -draw "rectangle 0,448,960,480" -font Bitstream-Vera-Sans -pointsize 16 -gravity southeast -fill black -annotate +6+6 "CC BY-SA 4.0 J. Seguinot (2020). Contains modified Copernicus Sentinel data. Processed with SentinelFlow."'

# diff color using git
alias diff='git diff --no-index'
alias wdiff='diff --word-diff'

# git aliases
alias code.remote='for repo in ~/git/code/*; do echo == $repo; git -C $repo remote --verbose; done'
alias code.status='for repo in ~/git/code/*; do echo == $repo; git -C $repo status --short; done'
alias code.pull='for repo in ~/git/code/*; do echo == $repo; git -C $repo pull --rebase; done'
alias code.push='for repo in ~/git/code/*; do echo == $repo; git -C $repo push --tags; done'
alias work.remote='for repo in ~/git/work/*; do echo == $repo; git -C $repo remote --verbose; done'
alias work.status='for repo in ~/git/work/*; do echo == $repo; git -C $repo status --short; done'
alias work.pull='for repo in ~/git/work/*; do echo == $repo; git -C $repo pull --rebase; done'
alias work.push='for repo in ~/git/work/*; do echo == $repo; git -C $repo push --tags; done'

# ghostscript aliases
alias pdfcompress='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDownsampleColorImages=false -dNOPAUSE -dQUIET -dBATCH -sOutputFile=-'
alias pdfdownsamp='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDownsampleColorImages=true -dNOPAUSE -dQUIET -dBATCH -sOutputFile=-'

# pylint aliases
alias pylint='pylint --output-format=colorized'
alias pylint.dups='pylint --disable=all --enable=duplicate-code --ignore-imports=yes'
alias git.dups='pylint.dups $(find ~/git -name "*.py")'
alias code.dups='pylint.dups $(find ~/git/code -name "*.py")'
alias work.dups='pylint.dups $(find ~/git/work -name "*.py")'

# rsync aliases
# PISM output files excluded when leaving ETHZ:
# - alpflo1(.500m)*/out*{1..9}0.nc: 45/51 out files = 459 GB
# - cisbed4.3km*/out*{1..9}000.nc: 207(-1)/229 out files = 560 GB
alias backup='rsync -vahP --delete --exclude={.cache,.googleearth,.local,.Skype,.thumbnails,.Trash*}'
alias backup.home='backup ~/ /run/media/julien/archive/home'
alias backup.archive='backup /run/media/julien/archive/ /run/media/julien/backup'
alias pism.sync='rsync -vahP --exclude={*~,*backup.nc,slurm*,SSAFD*,*failed.nc}'
alias pism.sync.input='pism.sync --delete ~/pism/input ela:pism/'
alias pism.sync.output.project='ssh daint pism.sync /scratch/snx3000/jsegu/ /project/s886/jsegu'
alias pism.sync.output.local='pism.sync ela:/project/s886/jsegu/pism/output ~/pism \
    --exclude=output/1.1.3/{alpflo1*/out*{1..9}0,cisbed4.3km*/out*{1..9}000}.nc \
    --include=output/1.1.3/cisbed4.3km.epica.*/out.0109000.nc'
alias pism.sync.output='pism.sync.output.project && pism.sync.output.local'

# sentinel aliases
alias sf.tileusage='ls $S2/granules | cut -c 5-10 | sort | uniq | while read tile ; do echo $(du -shc $S2/granules/*${tile}* | tail -1) $tile ; done | sort -h'
alias sf.zoneusage='ls $S2/granules | cut -c 5-7 | sort | uniq | while read tile ; do echo $(du -shc $S2/granules/*${tile}* | tail -1) $tile ; done | sort -h'

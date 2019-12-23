# Copyright (c) 2013--2019, Julien Seguinot <seguinot@vaw.baug.ethz.ch>
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


# Installed commands
# ------------------

# imagemagick aliases
alias 1920p='convert -resize 1920x1920 -quality 95'
alias 3840p='convert -resize 3840x3840 -quality 95'

# diff color using git
alias diff='git diff --no-index'
alias wdiff='diff --word-diff'

# ghostscript aliases
alias pdfcompress='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDownsampleColorImages=false -dNOPAUSE -dQUIET -dBATCH -sOutputFile=-'
alias pdfdownsamp='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDownsampleColorImages=true -dNOPAUSE -dQUIET -dBATCH -sOutputFile=-'

# rsync aliases
alias backup='rsync -vahP --delete --exclude={.cache,.googleearth,.local,.Skype,.thumbnails,.Trash*}'
alias backup.home='backup ~/ /run/media/julien/archive/home'
alias backup.archive='backup /run/media/julien/archive/ /run/media/julien/backup'

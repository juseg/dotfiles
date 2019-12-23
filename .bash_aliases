# Bash aliases
# ============

# Color aliases
# -------------

# color for ls
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# color for grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# color diff using git
alias diff='git diff --no-index'
alias wdiff='diff --word-diff'

# Various aliases
# ---------------

# cd aliases
alias ..='cd ..'
alias cd..='cd ..' 

# du aliases
alias da='du -had1 . | sed -e "s:./::"'
alias ds='du -had1 . | sed -e "s:./::" | sort -h'

# ls aliases
alias ll='ls -hl'
alias la='ls -A'
alias lal='ls -Ahl'
alias lt='ls -hlt'
alias lat='ls -Ahlt'
alias l='ls -CF'

# more aliases
alias reduce='mogrify -resize 1920x1920 -quality 85'
alias pdfcompress='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDownsampleColorImages=false -dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressed.pdf'
alias pdfdownsamp='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDownsampleColorImages=true -dColorImageResolution=127 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=downsamp.pdf'
alias whoruns='ps aux | cut -d " " -f 1 | sed "1 d" | sort | uniq'
alias whybusy='ps -lfp $(fuser -c /media/backup/)'

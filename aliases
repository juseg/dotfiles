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

# pep8 aliases
alias pep8loose='pep8 --ignore=E121,E122,E123,E124,E125,E126,E127,E128,E201,E202,E203,E211,E221,E222,E225,E231,E241,E251,E261,E271,E272,E302,E303,E502,W191,W291,W293'
alias pep8grass='pep8 --ignore=E121,E123,E126,E226,E24,E704,E265,W391'
alias pep8tough='pep8 --ignore='

# Code loo def gra tou sample message
#
# E121  *   *   *      continuation line under-indented for hanging indent
# E122  *              continuation line missing indentation or outdented
# E123  *   *   *      closing bracket does not match indentation of opening bracket’s line
# E124  *              closing bracket does not match visual indentation
# E125  *              continuation line with same indent as next logical line
# E126  *   *   *      continuation line over-indented for hanging indent
# E127  *              continuation line over-indented for visual indent
# E128  *              continuation line under-indented for visual indent
# E133      *          closing bracket is missing indentation
# E201  *              whitespace after ‘(‘
# E202  *              whitespace before ‘)’
# E203  *              whitespace before ‘:’
# E211  *              whitespace before ‘(‘
# E221  *              multiple spaces before operator
# E222  *              multiple spaces after operator
# E225  *              missing whitespace around operator
# E226      *   *      missing whitespace around arithmetic operator
# E231  *              missing whitespace after ‘,’, ‘;’, or ‘:’
# E241  *   *          multiple spaces after ‘,’
# E242      *          tab after ‘,’
# E251  *              unexpected spaces around keyword / parameter equals
# E261  *              at least two spaces before inline comment
# E265          *      block comment should start with ‘# ‘
# E271  *              multiple spaces after keyword
# E272  *              multiple spaces before keyword
# E302  *              expected 2 blank lines, found 0
# E303  *              too many blank lines (3)
# E502  *              the backslash is redundant between brackets
# E704      *   *      multiple statements on one line (def)
# W191  *              indentation contains tabs
# W291  *              trailing whitespace
# W293  *              blank line contains whitespace

# more aliases
alias reduce='mogrify -resize 1920x1920 -quality 85'
alias nccrop='ncks -O -d longitude,0.5,359.5 -d latitude,-89.5,89.5'
alias pdfcompress='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDownsampleColorImages=false -dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressed.pdf'
alias pdfdownsamp='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDownsampleColorImages=true -dColorImageResolution=127 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=downsamp.pdf'
alias whoruns='ps aux | cut -d " " -f 1 | sed "1 d" | sort | uniq'
alias whybusy='ps -lfp $(fuser -c /media/backup/)'

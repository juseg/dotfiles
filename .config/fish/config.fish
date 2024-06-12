# Copyright (c) 2023-2024, Julien Seguinot (juseg.dev)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# ~/.config/fish/config.fish -- Fish shell configuration file

# -- Fish greeting -----------------------------------------------------------
#
# replace default greeting with nothing
set -g fish_greeting

# -- Key bindings ------------------------------------------------------------
#
# NOTE: alternatively fish will call fish_user_key_bindings if it exists

# autocomplete with Ctrl-y
bind \cy accept-autosuggestion

# -- Abbreviations -----------------------------------------------------------
#
# NOTE: I understand from fish docs the preferred way is to save abbreviations
# as functions in ./functions, but isn't it a pain to maintain so many files?

# application shortcuts
abbr a aerc
abbr c cd
abbr d gio trash
abbr g git
abbr l ls
abbr v nvim
abbr z nvim -c 'Zen'

# du -- list directories disk usage on-the-fly or sorted
abbr da 'du -had1 . | sed -e s:./::'
abbr ds 'du -had1 . | sed -e s:./:: | sort -h'

# git -- commands
abbr ga git add
abbr gb git branch
abbr go git checkout
abbr gc git commit
abbr gd git diff
abbr gl git log
abbr gg git pull
abbr gp git push
abbr gr git rm
abbr gs git status

# ghostscript -- compress pdf with optional downsampling
abbr pdfcomp gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 \
    -dDownsampleColorImages=false -dNOPAUSE -dQUIET -dBATCH -sOutputFile=-
abbr pdfdown gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 \
    -dDownsampleColorImages=true -dNOPAUSE -dQUIET -dBATCH -sOutputFile=-

# magick -- resize images to canonical resolutions
abbr 1k magick convert -resize 960x960 -quality 95
abbr 2k magick convert -resize 1920x1920 -quality 95
abbr 4k magick convert -resize 3840x3840 -quality 95

# neovim -- open neovim splits
abbr vim nvim
abbr vh nvim -o
abbr vv nvim -O

# pylint -- color output and find duplicate code across repos
abbr lint pylint --output-format=colorized
abbr dups pylint --output-format=colorized --disable=all \
    --enable=duplicate-code --ignore-imports=yes $(find ~/git -name "*.py")

# rsync -- backup chain home -> archive -> backup
abbr bh rsync --archive --partial --progress --verbose --delete \
    --exclude={.cache,.googleearth,.local} ~/ /run/media/julien/archive/home
abbr ba rsync --archive --partial --progress --verbose --delete \
    /run/media/julien/archive/ /run/media/julien/backup

# rsync -- sync PISM input and output files (to include a scratch step use
# abbr pso ssh saga rsync [...] /scratch/... /project/...; \
#     rsync [...] saga:pism/output/ ~/pism/output)
abbr psi rsync --archive --partial --progress --verbose --delete \
    ~/pism/input saga:pism/
abbr pso rsync --archive --partial --progress --verbose \
    --exclude="{*_backup.nc,*_max_thickness.nc,*~,SSAFD*,slurm*}" \
    saga:pism/output/ ~/pism/output

# sed -- replace email with site url in copyright headers
abbr hidemail sed -i "1,5 s/<.*seg.*@.*>/(juseg.github.io)/g"

# xrandr -- switch to external or internal display
abbr dpe xrandr --output eDP1 --off --output DP1 --mode 1920x1080
abbr dpi xrandr --output DP1 --off --output eDP1 --mode 1920x1080

# openconnect-sso -- the annoying uib vpn
abbr vpn openconnect-sso --server https://vpn3.uib.no


# -- Actual aliases ----------------------------------------------------------

# wget -- fix wget hosts file location
alias wget "wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

# mbsync -- needed until version 1.5
alias mbsync "mbsync -c $XDG_CONFIG_HOME/mbsync/config"


# -- Fish Git prompt ---------------------------------------------------------
#
# NOTE: I could not really understand if it's best to define these here, in a
# ./functions/fish_git_prompt, or in ./fish_variables.

# configure git prompt
set __fish_git_prompt_show_informative_status 1  # dirty files, unpushed, etc
set __fish_git_prompt_use_informative_chars 0
set __fish_git_prompt_showdirtystate 1  # uncommitted changes
set __fish_git_prompt_showuntrackedfiles 1  # untracked files (slow)
set __fish_git_prompt_showupstream informative  # commits ahead/behind if any
set __fish_git_prompt_showstashstate 1  # number of stashes
set __fish_git_prompt_describe_style branch
set __fish_git_prompt_showcolorhints 1  # color

# git prompt flags in the order they appear
set __fish_git_prompt_char_stateseparator '|'   # between branch and flags
set __fish_git_prompt_char_cleanstate     '✓'   # when nothing else applies
set __fish_git_prompt_char_dirtystate     '*'   # unstaged changes
set __fish_git_prompt_char_invalidstate   '!'   # changes to staged files
set __fish_git_prompt_char_stagedstate    '+'   # staged for commit
set __fish_git_prompt_char_untrackedfiles '?'   # untracked files
set __fish_git_prompt_char_stashstate     '$'   # stash entries

# git prompt colors in the order they appear
set __fish_git_prompt_color_branch green        # when nothing else applies
set __fish_git_prompt_color_branch_detached red     # detached head
set __fish_git_prompt_color_branch_dirty yellow     # unstaged changes
set __fish_git_prompt_color_branch_staged yellow    # staged changes
set __fish_git_prompt_color_cleanstate green    # when nothing else applies
set __fish_git_prompt_color_flags yellow        # anything else but invalid
set __fish_git_prompt_color_invalidstate red    # changes to staged files

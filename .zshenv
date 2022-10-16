# Copyright (c) 2022, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# ~/.zshenv - Zsh user environment variables for interactive and login shells

# favourite programs
export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/nvim
export PAGER=/usr/bin/less

# expand path
export PATH=$HOME/.local/share/gem/ruby/2.7.0/bin:$PATH
export PATH=$HOME/git/code/dotfiles/bin:$PATH
export PATH=$HOME/git/code/sentinelflow:$PATH

# local python modules
export PYTHONPATH=""
export PYTHONPATH=$HOME/git/arch/cartowik:$PYTHONPATH
export PYTHONPATH=$HOME/git/code/hyoga:$PYTHONPATH

# local latex packages
export TEXMFHOME=$HOME/.local/share/texmf

# gtk2 config, used by epdfview, lxappearance, viewnior
# (epdfview is discontinued, should consider evince or mupdf)
export GTK2_RC_FILES="$HOME/.config/gtk-2.0"

# used by manjaro-settings-manager
export QT_QPA_PLATFORMTHEME="qt5ct"

# https://wiki.archlinux.org/title/SSH_keys#Start_ssh-agent_with_systemd_user
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

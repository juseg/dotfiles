# Copyright (c) 2022, Julien Seguinot (juseg.github.io)
# GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
#
# ~/.zshrc - Zsh config for both interactive and login shells (unlike .bashrc)

# source manjaro zsh config
for filepath in /usr/share/zsh/manjaro-zsh-{config,prompt}
    [ -e $filepath ] && source $filepath

# hardcoded in manjaro config, overwrite
export HISTFILE="$XDG_DATA_HOME/history"

# source shell aliases
source $XDG_CONFIG_HOME/shell/aliases

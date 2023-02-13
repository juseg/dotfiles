-- Copyright (c) 2013-2023, Julien Seguinot (juseg.github.io)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/init.lua - Neovim configuration file using lua script
--
-- ### Archlinux packages
-- - neovim
-- - neovim-cmp                     # the autocompletion engine
-- - neovim-cmp-buffer-git          # autocomplete from current buffer
-- - neovim-cmp-latex-symbols-git   # autocomplete latex symbols
-- - neovim-cmp-nvim-lsp-git        # autocomplete from language server
-- - neovim-cmp-nvim-lua-git        # autocomplete lua code
-- - neovim-cmp-path-git            # autocomplete paths
-- - neovim-lspconfig               # language server config files
-- - python-lsp-server              # language server for python
-- - vim-airline                    # vim airline also for neovim
-- - vim-airline-gruvbox-git        # vim airline gruvbox theme

require('autocmd')      -- automatic commands
require('remap')        -- key mappings
require('set')          -- neovim settings


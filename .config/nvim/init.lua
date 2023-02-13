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

require('remap')        -- key mappings
require('set')          -- neovim settings

-- ### Zen mode (-> lua/zen.lua)

-- configure neovim zen mode (AUR package neovim-zen-mode-git)
require("zen-mode").setup {
  window = {
    width = 96, -- width of the zen window (chars, fraction or function)
    height = 0.8, -- height of the zen window (chars, fraction or function)
    options = {
      colorcolumn= "0", -- disable color column
      cursorline = false, -- disable cursorline
      number = false, -- disable number column
      signcolumn = "no", -- disable signcolumn
    },
  },
}

-- ### Auto command

-- when saving file
vim.cmd('autocmd BufWritePre * %s/\\s\\+$//e')  -- remove trailing space

-- color fish files with zsh syntax (FIXME use treesitter instead)
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
    pattern = '*.fish',
    command = 'set syntax=zsh'})

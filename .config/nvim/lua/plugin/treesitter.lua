-- Copyright (c) 2023-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/treesitter.lua - Language parsing ---------------

-- better highlightning and much more
return {
  { 'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function ()
      require('nvim-treesitter.configs').setup({
        auto_install = true, -- auto install missing parsers in this buffer
        ensure_installed = { 'lua', 'python', 'vimdoc' }, -- always install
        highlight = { enable = true }, -- set to false to disable extension
      })
    end
  }
}

-- Copyright (c) 2022-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/zenmode.lua - Zen mode --------------------------

-- configure neovim zen mode
return {
  { 'folke/zen-mode.nvim',
    opts = {
      window = {
        width = 96, -- width of the zen window (chars, fraction or function)
        height = 0.8, -- height of the zen window (chars, fraction or function)
        options = {
          colorcolumn = "0", -- disable color column
          cursorline = false, -- disable cursor line
          relativenumber = false, -- disable numbers
          signcolumn = "no", -- disable signcolumn
        },
      },
      -- disable autocompletion FIXME will this work with lazy-loading?
      on_open = function()
          require('cmp').setup.buffer { enabled = false }
      end,
      on_close = function()
          require('cmp').setup.buffer { enabled = true }
          vim.cmd.quit{mods={confirm=true}}
      end,
    }
  }
}

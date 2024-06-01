-- Copyright (c) 2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/whichkey.lua - Keymap popup ---------------------

-- shows popup with keymaps of the command started
return {
  'folke/which-key.nvim',

  -- set prefixes (see https://github.com/folke/which-key.nvim/issues/514)
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
    require('which-key').register({
      ['<leader>c'] = { name = 'code', ['#'] = 'which_key_ignore' },
      ['<leader>f'] = { name = 'find'},
      ['<leader>g'] = { name = 'goto'},
      ['<leader>h'] = { name = 'hunk', ['#'] = 'which_key_ignore' },
    })
  end,

  -- fix separator (see https://github.com/folke/which-key.nvim/issues/409)
  opts = {
    icons = { separator = '-' },
    key_labels = { ['<space>'] = '<sp>' },
  }
}

-- Copyright (c) 2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/colors.lua - Colorschemes -----------------------

-- lua port of gruvbox colorscheme
return {
  { 'ellisonleao/gruvbox.nvim',
    config = function(_, opts)
      require('gruvbox').setup(opts)
      vim.cmd.colorscheme('gruvbox')
    end,
    opts = { transparent_mode = true },
  },
}

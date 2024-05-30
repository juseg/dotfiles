-- Copyright (c) 2023-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/lualine.lua - Status line in lua ----------------

-- blazing fast status line
return {
  'nvim-lualine/lualine.nvim',
  config = true,
  opts = { sections = { lualine_x = {'encoding', 'fileformat', 'filetype', {
    require('lazy.status').updates,
    cond = require('lazy.status').has_updates } } } }
}

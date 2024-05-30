-- Copyright (c) 2023-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/comment.lua - Toggle comments -------------------

-- soon outdated (https://github.com/terrortylor/nvim-comment/issues/60)
return {
  { 'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup()
    end,
  },
}

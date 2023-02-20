-- ~/.config/nvim/after/plugin/colors.lua - Colorscheme ----------------------

-- transparent gruvbox
require("gruvbox").setup({transparent_mode = true})
vim.cmd.colorscheme('gruvbox')

-- transparent background for any other colorscheme
-- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none'})
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none'})

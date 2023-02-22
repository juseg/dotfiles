-- ~/.config/nvim/lua/autocmd.lua - Automatic commands -----------------------

-- when saving file
vim.cmd('autocmd BufWritePre * %s/\\s\\+$//e') -- remove trailing space

-- ~/.config/nvim/lua/autocmd.lua - Automatic commands -----------------------

-- when saving file
vim.cmd('autocmd BufWritePre * %s/\\s\\+$//e') -- remove trailing space

-- color fish files with zsh syntax (FIXME use treesitter instead)
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
    pattern = '*.fish',
    command = 'set syntax=zsh'})

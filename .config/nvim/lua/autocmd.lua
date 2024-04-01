-- ~/.config/nvim/lua/autocmd.lua - Automatic commands -----------------------

-- when saving file
vim.cmd('autocmd BufWritePre * %s/\\s\\+$//e') -- remove trailing space

-- edit emails in zen mode
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = '*.eml',
    callback = function(args)
        vim.cmd.ZenMode()
        vim.opt.textwidth = 0
    end
})

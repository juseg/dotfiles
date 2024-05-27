-- ~/.config/nvim/lua/autocmd.lua - Automatic commands -----------------------

-- remove trailing space outside diffs
vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
        if vim.bo.filetype ~= 'diff' then
            vim.cmd([[%s/\s\+$//e]])
        end
    end
})

-- edit emails in zen mode
vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*.eml',
    callback = function()
        vim.cmd.ZenMode()
        vim.opt.textwidth = 0
    end
})

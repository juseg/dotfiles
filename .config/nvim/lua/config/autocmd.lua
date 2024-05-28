-- Copyright (c) 2019-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/config/autocmd.lua - Automatic commands ----------------

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

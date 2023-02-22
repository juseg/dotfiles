-- ~/.config/nvim/after/plugin/gitsigns.lua - Git signs in gutter ------------

-- buffer mappings
require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- hunk navigation (from gitsigns readme)
        vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { buffer = bufnr, expr = true })
        vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { buffer = bufnr, expr = true })

        -- actions on hunks
        local opts = { buffer = bufnr }
        vim.keymap.set({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, opts)
        vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, opts)
        vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts)
        vim.keymap.set('n', '<leader>hb', gs.blame_line, opts)
        vim.keymap.set('n', '<leader>hd', gs.diffthis, opts)

        -- actions on buffer
        vim.keymap.set('n', '<leader>hS', gs.stage_buffer, opts)
        vim.keymap.set('n', '<leader>hR', gs.reset_buffer, opts)
    end
}

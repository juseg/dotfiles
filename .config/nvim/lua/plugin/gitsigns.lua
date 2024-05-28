-- Copyright (c) 2023-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/gitsigns.lua - Git signs in gutter --------------

-- git signs and hunk commands
return {
  { "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- hunk navigation (from gitsigns readme)
        -- FIXME can be simplified thanks to lazy-loading
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

      end,
    },
  },
}

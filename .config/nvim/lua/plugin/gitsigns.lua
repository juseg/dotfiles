-- Copyright (c) 2023-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/gitsigns.lua - Git signs in gutter --------------

-- git signs and hunk commands
return {
  { 'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(buffer)

        -- local aliases for concision
        local gs = package.loaded.gitsigns
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
        end

        -- hunk navigation
        map('n', ']h', function() gs.nav_hunk('next') end, 'Next hunk')
        map('n', '[h', function() gs.nav_hunk('prev') end, 'Prev hunk')
        map('n', ']H', function() gs.nav_hunk('last') end, 'Last hunk')
        map('n', '[H', function() gs.nav_hunk('first') end, 'First hunk')

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

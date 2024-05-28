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
        map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, 'Stage hunk')
        map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, 'Reset hunk')
        map('n', '<leader>hb', gs.blame_line, 'Blame line')
        map('n', '<leader>hB', function() gs.blame_line({ full = true }) end,
            'Blame with diff')
        map('n', '<leader>hi', gs.preview_hunk_inline, 'Preview hunk inline')
        map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>ht', gs.toggle_deleted, 'Toggle deletions')
        map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')

        -- actions on buffer
        map('n', '<leader>hd', gs.diffthis, 'Diff to index')
        map('n', '<leader>hD', function() gs.diffthis('~') end, 'Diff to ~')
        map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
        map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')

        -- text selection
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<cr>', 'in hunk')

      end,
    },
  },
}

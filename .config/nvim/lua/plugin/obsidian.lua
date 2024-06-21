-- Copyright (c) 2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/obsdian.lua - Obsidian vaults -------------------

-- load obsidian on markdown files
return {
  'epwalsh/obsidian.nvim',
  init = function() vim.opt.conceallevel = 1 end, -- conceal checkboxes etc
  version = '*', -- recommended, use latest release instead of latest commit
  ft = 'markdown', -- load obsidian on any markdown file
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'hrsh7th/nvim-cmp',      -- optional, complete links and tags
  },
  keys = {
    { '<leader>od', '<cmd>ObsidianDailies<cr>', desc = 'Open daily note' },
    { '<leader>on', '<cmd>ObsidianNew<cr>', desc = 'Create new note' },
    { '<leader>oo', '<cmd>ObsidianOpen<cr>', desc = 'Open in Obsidian' },
      -- check README for more commands
  },
  opts = {
    disable_frontmatter = true, -- don't manage frontmatter for now
    workspaces = { { name = 'vault', path = '~/git/note/vault' } },

    daily_notes = {
        alias_format = '%a %-d %b %Y',  -- title of new daily note
        date_format = '%Y/%y%m%d',      -- path to daily notes
        folder = 'diary/daily',         -- daily notes folder
        -- template = 'daily.md',       -- template for new notes
    },
  },
}

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
    -- { '<leader>ot', '<cmd>ObsidianTemplate<cr>', desc = 'Insert template'},
    { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Open backlinks'},
    { '<leader>oc', '<cmd>ObsidianToggleCheckbox<cr>', desc = 'Check box'},
    { '<leader>od', '<cmd>ObsidianDailies<cr>', desc = 'Open daily note' },
    { '<leader>oe', '<cmd>ObsidianExtractNote<cr>', desc = 'Extract to note'},
    { '<leader>og', '<cmd>ObsidianFollowLink<cr>', desc = 'Go to reference'},
    { '<leader>oi', '<cmd>ObsidianPasteImg<cr>', desc = 'Paste image in note'},
    { '<leader>ol', '<cmd>ObsidianLinks<cr>', desc = 'List links'},
    { '<leader>on', '<cmd>ObsidianNew<cr>', desc = 'Create new note' },
    { '<leader>oo', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Open in neovim'},
    { '<leader>or', '<cmd>ObsidianRename<cr>', desc = 'Rename and relink (!)'},
    { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = 'Search inside notes'},
    { '<leader>ot', '<cmd>ObsidianTags<cr>', desc = 'List tag references'},
    { '<leader>ok', '<cmd>ObsidianToday<cr>', desc = "Open today's note"},
    { '<leader>ow', '<cmd>ObsidianWorkspace<cr>', desc = 'Change workspace'},
    { '<leader>ox', '<cmd>ObsidianOpen<cr>', desc = 'Open in Obsidian' },
    { '<leader>oy', '<cmd>ObsidianYesterday<cr>', desc = 'Open yesterday note'},
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

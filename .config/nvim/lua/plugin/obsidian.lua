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
  dependencies = { 'nvim-lua/plenary.nvim' }, -- required.
  opts = {
    disable_frontmatter = true, -- don't manage frontmatter for now
    workspaces = { { name = 'vault', path = '~/git/note/vault' } } },
}

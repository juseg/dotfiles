-- Copyright (c) 2023-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/telescope.lua - Fuzzy finder etc ----------------

-- lazy-load on keys
return {

  -- telescope vanilla
  { 'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'https://git.hubrecht.ovh/hubrecht/telescope-notmuch.nvim'
    },
    module = true,
    keys = {

      -- find pickers
      { '<leader>fb', '<cmd>Telescope buffers<cr>',
        desc = 'Find buffers' },
      { '<leader>fc', '<cmd>Telescope command_history<cr>',
        desc = 'Find in history' },
      { '<leader>fd', '<cmd>Telescope diagnostics<cr>',
        desc = 'Find diagnostics' },
      { '<leader>fe', '<cmd>Telescope commands<cr>',
        desc = 'Find commands' },
      { '<leader>ff', '<cmd>Telescope find_files<cr>',
        desc = 'Find files' },
      { '<leader>fg', '<cmd>Telescope git_files<cr>',
        desc = 'Find git files' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>',
        desc = 'Find help tags' },
      { '<leader>fk', '<cmd>Telescope keymaps<cr>',
        desc = 'Find keymaps' },
      { '<leader>fm', '<cmd>Telescope man_pages<cr>',
        desc = 'Find man pages' },
      { '<leader>fo', '<cmd>Telescope vim_options<cr>',
        desc = 'Find options' },
      { '<leader>fp', '<cmd>Telescope builtin<cr>',
        desc = 'Find pickers' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>',
        desc = 'Find recent' },
      { '<leader>fs', '<cmd>Telescope spell_suggest<cr>',
        desc = 'Find spelling' },
      { '<leader>ft', '<cmd>Telescope filetypes<cr>',
        desc = 'Find filetypes' },
      { '<leader>fw', '<cmd>Telescope live_grep<cr>',
        desc = 'Find with ripgrep' },
      { '<leader>fx', '<cmd>Telescope planets<cr>',
        desc = 'Find planets' },
      { '<leader>fz', '<cmd>Telescope current_buffer_fuzzy_find<cr>',
        desc = 'Find fuzzily' },

      -- git pickers
      { '<leader>gl', '<cmd>Telescope git_commits<cr>',
        desc = 'Git log for repo' },
      { '<leader>gh', '<cmd>Telescope git_bcommits<cr>',
        desc = 'Git file history' },
      { '<leader>gb', '<cmd>Telescope git_branches<cr>',
        desc = 'Git branches' },
      { '<leader>gs', '<cmd>Telescope git_status<cr>',
        desc = 'Git status' },

      -- lsp pickers
      { '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>',
        desc = 'Document symbols' },
      { '<leader>lw', '<cmd>Telescope lsp_workspace_symbols<cr>',
        desc = 'Workspace symbols' },
      { '<leader>ld', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
        desc = 'Dynamic symbols' },

      -- FIXME move to lsp.lua
      { 'gr', '<cmd>Telescope lsp_references<cr>',
        desc = 'Go to references' },
      { 'gi', '<cmd>Telescope lsp_implementations<cr>',
        desc = 'Go to implementations' },
      { 'gd', '<cmd>Telescope lsp_definitions<cr>',
        desc = 'Go to definitions' },
      { 'gt', '<cmd>Telescope lsp_type_definitions<cr>',
        desc = 'Go to type definitions' },

      -- treesitter picker
      { '<leader>ts', '<cmd>Telescope treesitter<cr>',
        desc = 'Treesitter symbols!' },
    }
  },

  -- notmuch adresses
  { 'https://git.hubrecht.ovh/hubrecht/telescope-notmuch.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    keys = { {
      '<leader>fa', '<cmd>Telescope notmuch theme=cursor<CR>',
      desc = 'Find adresses' } },
  }
}

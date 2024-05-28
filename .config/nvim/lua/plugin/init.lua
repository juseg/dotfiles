-- ~/.config/nvim/lua/plugin/init.lua - Plugin manager  ----------------------

-- FIXME move plugin specs along with after files to separate files
-- (see https://github.com/folke/lazy.nvim#-structuring-your-plugins)
return {

    -- plugin manager
    -- 'wbthomason/packer.nvim'         -- packer manages itself

    -- lua plugins
    'folke/zen-mode.nvim',              -- distraction-free mode
    'lewis6991/gitsigns.nvim',          -- git signs in gutter
    'mbbill/undotree',                  -- undo tree with branches
    'nvim-lualine/lualine.nvim',        -- blazing fast status line
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = {
        'https://git.hubrecht.ovh/hubrecht/telescope-notmuch.nvim',
        'nvim-lua/plenary.nvim' } },    -- fuzzy file finder
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

    -- autocompletion and lsp
    -- (FIXME choose mason auto-install or Manjaro packages)
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v1.x', dependencies = {

        -- LSP Support
        'neovim/nvim-lspconfig',        -- language server config (required)
        -- {'williamboman/mason.nvim'},           -- manage servers (optional)
        -- {'williamboman/mason-lspconfig.nvim'}, -- manage servers (optional)

        -- Autocompletion
        'hrsh7th/cmp-nvim-lsp',         -- complete from lsp (required)
        'hrsh7th/nvim-cmp',             -- complete engine (required)
        'hrsh7th/cmp-buffer',           -- complete from buffer (optional)
        'hrsh7th/cmp-path',             -- complete paths (optional)
        'hrsh7th/cmp-nvim-lua',         -- complete runtime nvim (optional)
        'saadparwaiz1/cmp_luasnip',     -- complete from snippets (optional)

        -- Snippets
        'L3MON4D3/LuaSnip',             -- snippets engine (required)
        'rafamadriz/friendly-snippets', -- snippets definitions (optional)
    } }

}

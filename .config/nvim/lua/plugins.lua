-- ~/.config/nvim/lua/plugins.lua - Plugin manager  --------------------------

return require('packer').startup(function(use)

    -- plugin manager
    use { 'wbthomason/packer.nvim' }    -- packer manages itself

    -- lua plugins
    use { 'ellisonleao/gruvbox.nvim' }  -- lua port of gruvbox colorscheme
    use { 'folke/zen-mode.nvim' }       -- distraction-free mode
    use { 'lewis6991/gitsigns.nvim' }   -- git signs in gutter
    use { 'mbbill/undotree' }           -- undo tree with branches
    use { 'nvim-lualine/lualine.nvim' } -- blazing fast status line
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = {
        { 'nvim-lua/plenary.nvim' } } } -- fuzzy file finder
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSupdate' }

    -- vim script plugins
    use { 'tpope/vim-fugitive' }        -- git commands in buffers

    -- autocompletion and lsp
    -- (FIXME choose mason auto-install or Manjaro packages)
    use { 'VonHeikemen/lsp-zero.nvim', branch = 'v1.x', requires = {

        -- LSP Support
        {'neovim/nvim-lspconfig'},      -- language server config (required)
        -- {'williamboman/mason.nvim'},           -- manage servers (optional)
        -- {'williamboman/mason-lspconfig.nvim'}, -- manage servers (optional)

        -- Autocompletion
        { 'hrsh7th/cmp-nvim-lsp' },     -- complete from lsp (required)
        { 'hrsh7th/nvim-cmp' },         -- complete engine (required)
        { 'hrsh7th/cmp-buffer' },       -- complete from buffer (optional)
        { 'hrsh7th/cmp-path' },         -- complete paths (optional)
        { 'hrsh7th/cmp-nvim-lua' },     -- complete runtime nvim (optional)
        { 'saadparwaiz1/cmp_luasnip' }, -- complete from snippets (optional)

        -- Snippets
        {'L3MON4D3/LuaSnip'},             -- snippets engine (required)
        {'rafamadriz/friendly-snippets'}, -- snippets definitions (optional)
    } }

end)

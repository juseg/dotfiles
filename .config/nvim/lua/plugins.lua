-- ~/.config/nvim/lua/plugins.lua - Plugin manager  --------------------------

return require('packer').startup(function(use)

    use { 'wbthomason/packer.nvim' }    -- packer manages itself

    use { 'ellisonleao/gruvbox.nvim' }  -- lua port of gruvbox colorscheme
    use { 'folke/zen-mode.nvim' }       -- distraction-free mode
    use { 'hrsh7th/cmp-nvim-lsp' }      -- autocomplete from language server
    use { 'hrsh7th/nvim-cmp' }          -- autocomplete engine
    use { 'lewis6991/gitsigns.nvim' }   -- git signs in gutter
    use { 'mbbill/undotree' }           -- undo tree with branches
    use { 'nvim-lualine/lualine.nvim' } -- blazing fast status line
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = {
        { 'nvim-lua/plenary.nvim' } } } -- fuzzy file finder
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSupdate' }

    -- current Manjaro / AUR packages
    -- - neovim-cmp                     # the autocompletion engine
    -- - neovim-cmp-buffer-git          # autocomplete from current buffer
    -- - neovim-cmp-latex-symbols-git   # autocomplete latex symbols
    -- - neovim-cmp-nvim-lsp-git        # autocomplete from language server
    -- - neovim-cmp-nvim-lua-git        # autocomplete lua code
    -- - neovim-cmp-path-git            # autocomplete paths
    -- - neovim-lspconfig               # language server config files
    -- - python-lsp-server              # language server for python

    -- to be added soon
    -- use { 'tpope/vim-fugitive' }

    -- compare this to current LSP setup
    -- use { 'VonHeikemen/lsp-zero.nvim', branch = 'v1.x', requires = {
    --     -- LSP Support
    --     {'neovim/nvim-lspconfig'},             -- Required
    --     {'williamboman/mason.nvim'},           -- Optional
    --     {'williamboman/mason-lspconfig.nvim'}, -- Optional
    --     -- Autocompletion
    --     {'hrsh7th/nvim-cmp'},         -- Required
    --     {'hrsh7th/cmp-nvim-lsp'},     -- Required
    --     {'hrsh7th/cmp-buffer'},       -- Optional
    --     {'hrsh7th/cmp-path'},         -- Optional
    --     {'saadparwaiz1/cmp_luasnip'}, -- Optional
    --     {'hrsh7th/cmp-nvim-lua'},     -- Optional
    --     -- Snippets
    --     {'L3MON4D3/LuaSnip'},             -- Required
    --     {'rafamadriz/friendly-snippets'}, -- Optional
    -- } }

end)

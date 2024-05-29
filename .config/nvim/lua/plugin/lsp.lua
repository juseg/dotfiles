-- Copyright (c) 2022-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/lsp.lua - Autocompletion and LSP ----------------

return {
  'neovim/nvim-lspconfig',        -- language server config (required)
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',         -- complete from lsp (required)
    'hrsh7th/nvim-cmp',             -- complete engine (required)
    'hrsh7th/cmp-buffer',           -- complete from buffer (optional)
    'hrsh7th/cmp-path',             -- complete paths (optional)
    'hrsh7th/cmp-nvim-lua',         -- complete runtime nvim (optional)
    'saadparwaiz1/cmp_luasnip',     -- complete from snippets (optional)
    'L3MON4D3/LuaSnip',             -- snippets engine (required)
    'rafamadriz/friendly-snippets', -- snippets definitions (optional)
    -- 'williamboman/mason.nvim',           -- manage servers (optional)
    -- 'williamboman/mason-lspconfig.nvim', -- manage servers (optional)
  },

  config = function()

    -- configure language servers
    local lspconfig = require('lspconfig')
    lspconfig.cssls.setup({})
    lspconfig.html.setup({})
    lspconfig.marksman.setup({})
    lspconfig.texlab.setup({})

    -- fix undefined global vim
    lspconfig.lua_ls.setup({
      settings = { Lua = { diagnostics = { globals = { 'vim' } } } } })

    -- enable pylint
    lspconfig.pylsp.setup({
      settings = { pylsp = { plugins = { pylint = { enabled = true } } } } })

    -- configure autocompletion
    local cmp = require('cmp')
    cmp.setup({
      experimental = { ghost_text = true },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
      }),
      snippet = { expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 } ,
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'path'},
      }),
      window = { completion = cmp.config.window.bordered() },
    })

    -- load friendly-snippets to luasnip
    require('luasnip.loaders.from_vscode').lazy_load()
    end
}

-- FIXME where does this needs to go?
-- -- additional keys on lsp-attached buffers (see nvim-lspconfig readme)
-- lsp.on_attach(function(client, bufnr)
--     local opts = { buffer = bufnr, remap = false }
--     vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
--     vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
--     vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
--     vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--     vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
--     vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--     vim.keymap.set('n', '<leader>wl', function()
--         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     end, opts)
--     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--     vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
--     vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
--     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
-- end)

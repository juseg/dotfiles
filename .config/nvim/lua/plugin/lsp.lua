-- Copyright (c) 2022-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/lsp.lua - Autocompletion and LSP ----------------

-- language server config and autocompletion
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

  -- configure cmp and lsp together
  config = function()

    -- auto-command on lsp-attached buffers
    local on_attach = function(_, buffer)

      -- highlight references (from :help document_highlight)
      vim.api.nvim_create_autocmd('CursorHold', {
          buffer = buffer, callback = vim.lsp.buf.document_highlight })
      vim.api.nvim_create_autocmd('CursorHoldI', {
          buffer = buffer,  callback = vim.lsp.buf.document_highlight })
      vim.api.nvim_create_autocmd('CursorMoved', {
          buffer = buffer,  callback = vim.lsp.buf.clear_references })

      -- additional keys on lsp-attached buffers
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
      end
      map('i', '<C-k>', vim.lsp.buf.signature_help, 'Inline help')
      map('n', 'K', vim.lsp.buf.hover, 'Hover help')
      map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
      map('n', '<leader>cf', vim.lsp.buf.format, 'Code format')
      map('n', '<leader>cr', vim.lsp.buf.rename, 'Code rename')
      map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder')
      map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
      map('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'List workspace folders')

    -- end on-attach auto-command
    end

    -- load default configurations
    local lspconfig = require('lspconfig')
    lspconfig.cssls.setup({ on_attach = on_attach })
    lspconfig.html.setup({ on_attach = on_attach })
    lspconfig.marksman.setup({ on_attach = on_attach })
    lspconfig.texlab.setup({ on_attach = on_attach })

    -- fix undefined global vim
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      settings = { Lua = { diagnostics = { globals = { 'vim' } } } } })

    -- enable pylint
    lspconfig.pylsp.setup({
      on_attach = on_attach,
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

    -- load friendly-snippets into luasnip
    require('luasnip.loaders.from_vscode').lazy_load()

  end
}

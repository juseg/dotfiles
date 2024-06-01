-- Copyright (c) 2022-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/plugin/lsp.lua - Autocompletion and LSP ----------------

-- language server config
return {
  'neovim/nvim-lspconfig',

  -- autocompletion dependencies
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

    -- highlight references (from :help document_highlight)
    local add_highlight = function(_, buffer)
      vim.api.nvim_create_autocmd('CursorHold', {
          buffer = buffer, callback = vim.lsp.buf.document_highlight })
      vim.api.nvim_create_autocmd('CursorHoldI', {
          buffer = buffer,  callback = vim.lsp.buf.document_highlight })
      vim.api.nvim_create_autocmd('CursorMoved', {
          buffer = buffer,  callback = vim.lsp.buf.clear_references })
    end

    -- additional keymaps on lsp-attached buffers
    local add_keymaps = function(_, buffer)
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
      end
      map('i', '<C-k>', vim.lsp.buf.signature_help, 'Inline help')
      map('n', 'K', vim.lsp.buf.hover, 'Hover help')
      map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
      map('n', '<leader>cd', vim.lsp.buf.add_workspace_folder,
          'Add workspace directory')
      map('n', '<leader>ce', vim.lsp.buf.remove_workspace_folder,
          'Exclude workspace directory')
      map('n', '<leader>cf', vim.lsp.buf.format, 'Format code with LSP')
      map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename object')
      map('n', '<leader>cw', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'List workspace folders')
    end

    -- default auto-command on lsp-attached buffers
    local on_attach = function(_, buffer)
      add_highlight(_, buffer)
      add_keymaps(_, buffer)
    end

    -- load default configurations
    local lspconfig = require('lspconfig')
    lspconfig.cssls.setup({ on_attach = on_attach })
    lspconfig.html.setup({ on_attach = on_attach })
    lspconfig.marksman.setup({ on_attach = add_keymaps })
    lspconfig.texlab.setup({ on_attach = on_attach })
    lspconfig.lua_ls.setup({ on_attach = on_attach, settings = {
      Lua = { diagnostics = { globals = { 'vim' } } } } })
    lspconfig.pylsp.setup({ on_attach = on_attach, settings = {
      pylsp = { plugins = { pylint = { enabled = true } } } } })

  end
}

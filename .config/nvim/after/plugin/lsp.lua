-- ~/.config/nvim/after/plugin/lsp.lua - Autocompletion and LSP --------------

-- fix formatting (hard word wrap) in neovim>=0.8 and pylsp
vim.opt.formatexpr = "pylsp#Format()"

-- popup menu, even for single match, with no match preselected
vim.opt.completeopt = menu,menuone,noselect

-- setup neovim-cmp (adapted from https://github.com/hrsh7th/nvim-cmp)
local cmp = require 'cmp'
cmp.setup {

  -- key mappings
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),    -- ??
    ['<C-f>'] = cmp.mapping.scroll_docs(4),     -- ??
    ['<C-Space>'] = cmp.mapping.complete(),     -- ??
    ['<C-e>'] = cmp.mapping.abort(),            -- close suggestions
    ['<CR>'] = cmp.mapping.confirm(             -- confirm current choice
      { select = true }), -- auto select first choice
  }),
  -- sources, ranked by priority
  sources = cmp.config.sources({
    -- { name = 'gh_issues' },                  -- looks useful
    { name = 'nvim_lua'},                       -- lua, useful to config vim
    { name = 'nvim_lsp'},                       -- language server protocol
    { name = 'path' },
    -- { name = 'luasnip' },                    -- code snippets
    -- { name = 'buffer', keyword_lenght = 5 }, -- buffer, a bit intrusive
  }),

  -- snippets, required accordint to nvim-cmp readme
  -- snippet = {
  --   expand = function(args)
  --     require('luasnip').lsp_expand(args.body)  -- For `luasnip` users.
  --   end,
  -- },

  -- formatting of each source
  -- to add icons see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        buffer = "[Buffer]",
        -- gh_issues = "[issues]",
        -- luasnip = "[snip]",
        nvim_lsp = "[LSP]",
        path = "[Path]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end
  },

  -- experimental features
  experimental = {
    ghost_text = true,          -- shows virtual text as you type
  },

  -- windows appearance (colors can be changed with highlight)
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
}

-- load lsp server for python
local lsp = require('lspconfig')
lsp.pylsp.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities())
}

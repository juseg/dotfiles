-- Copyright (c) 2013-2023, Julien Seguinot (juseg.github.io)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/init.lua - Neovim configuration file using lua script
--
-- ### Archlinux packages
-- - neovim
-- - neovim-cmp                     # the autocompletion engine
-- - neovim-cmp-buffer-git          # autocomplete from current buffer
-- - neovim-cmp-latex-symbols-git   # autocomplete latex symbols
-- - neovim-cmp-nvim-lsp-git        # autocomplete from language server
-- - neovim-cmp-nvim-lua-git        # autocomplete lua code
-- - neovim-cmp-path-git            # autocomplete paths
-- - neovim-lspconfig               # language server config files
-- - python-lsp-server              # language server for python
-- - vim-airline                    # vim airline also for neovim
-- - vim-airline-gruvbox-git        # vim airline gruvbox theme

require('remap')        -- key mappings
require('set')          -- neovim settings

-- fix formatting (hard word wrap) in neovim>=0.8 and pylsp
vim.opt.formatexpr = "pylsp#Format()"

-- ### Filetype specific
-- FIXME convert to lua script

-- python indentation
-- au BufNewFile,BufRead *.py
--     \ vim.opt.textwidth=79          -- used for text wrapping
--     \ vim.opt.colorcolumn=80        -- highlight column 80
--     \ vim.opt.fileformat=unix       -- always store in unix format
--     \ vim.opt.encoding=utf-8        -- especially for Python 3

-- restructured text indentation
-- au BufNewFile,BufRead *.rst
--     \ vim.opt.softtabstop=3         -- length of tabs in insert mode
--     \ vim.opt.shiftwidth=3          -- used by < and >

-- markdown folds
-- function! MarkdownLevel()
--     if getline(v:lnum) =~ '^# .*$'
--         return '>1'
--     endif
--     if getline(v:lnum) =~ '^## .*$'
--         return '>2'
--     endif
--     if getline(v:lnum) =~ '^### .*$'
--         return '>3'
--     endif
--     if getline(v:lnum) =~ '^#### .*$'
--         return '>4'
--     endif
--     if getline(v:lnum) =~ '^##### .*$'
--         return '>5'
--     endif
--     if getline(v:lnum) =~ '^###### .*$'
--         return '>6'
--     endif
--     return '='
-- endfunction
-- au BufEnter *.md setlocal foldexpr=MarkdownLevel()
-- au BufEnter *.md setlocal foldmethod=expr

-- ### Autocompletion

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

-- ### Zen mode (-> lua/zen.lua)

-- configure neovim zen mode (AUR package neovim-zen-mode-git)
require("zen-mode").setup {
  window = {
    width = 96, -- width of the zen window (chars, fraction or function)
    height = 0.8, -- height of the zen window (chars, fraction or function)
    options = {
      colorcolumn= "0", -- disable color column
      cursorline = false, -- disable cursorline
      number = false, -- disable number column
      signcolumn = "no", -- disable signcolumn
    },
  },
}

-- ### Auto command

-- when saving file
vim.cmd('autocmd BufWritePre * %s/\\s\\+$//e')  -- remove trailing space

-- color fish files with zsh syntax (FIXME use treesitter instead)
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
    pattern = '*.fish',
    command = 'set syntax=zsh'})

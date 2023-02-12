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

-- ### Key mappings (-> lua/remap.lua)

-- remap the mode key
vim.keymap.set('i', 'jj', '<esc>')

-- lint, execute and make shortcuts
vim.keymap.set('n', '<F7>', '<cmd>!flake8 %<cr>')   -- run flake8 on file
vim.keymap.set('n', '<F8>', '<cmd>!pylint %<cr>')   -- run pylint on file
vim.keymap.set('n', '<F9>', '<cmd>!%:p<cr>')        -- execute current file
vim.keymap.set('n', '<F12>', '<cmd>!make<cr>')      -- run make

-- commenting python code in visual mode
vim.keymap.set('v', 'cc', '<cmd>s/^/#/<cr>:noh<cr>|')   -- insert starting #
vim.keymap.set('v', 'cx', '<cmd>s/^#//<cr>:noh<cr>|')   -- remove starting #

-- split navigation
vim.keymap.set('n', '<C-J>', '<C-W><C-H>')  -- move to the split to the left
vim.keymap.set('n', '<C-K>', '<C-W><C-J>')  -- move to the split below
vim.keymap.set('n', '<C-I>', '<C-W><C-K>')  -- move to the split above
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')  -- move to the split to the right

-- ### Set vim options (-> lua/set.lua)

-- turn off bell
vim.opt.belloff = 'all'

-- line numbers and newlines
vim.opt.linebreak = true        -- break line between words
vim.opt.number = true           -- enable line numbering
vim.opt.relativenumber = false  -- relative line numbers
vim.opt.cursorline = true       -- highlight current line
vim.opt.colorcolumn = "80"      -- color column 80 (pep8 limit)

-- default indentation
vim.opt.expandtab = true        -- tabs as spaces
vim.opt.tabstop = 8             -- length of tabs in display
vim.opt.softtabstop = 4         -- length of tabs in insert mode
vim.opt.shiftwidth = 4          -- used by < and >
vim.opt.smartindent = true      -- auto indent new lines
vim.opt.autoindent = false      -- a bit less auto than smartindent

-- searching
vim.opt.ignorecase = false      -- case-insensitive search
vim.opt.incsearch = true        -- search while typing
vim.opt.smartcase = true        -- uppercase-only-sensitive search

-- split and navigation
vim.opt.splitbelow = true       -- open splits below
vim.opt.splitright = true       -- open splits to the right

-- code folding
vim.opt.foldmethod = "indent"   -- fold by indentation
vim.opt.foldlevel = 99          -- files open unfolded
vim.keymap.set('n', '<space>', 'za')  -- fold using spacebar

-- git integration
vim.opt.updatetime=100          -- reduce update time for gitgutter

-- highligh nbsp etc in list mode
-- FIXME rewrite in lua script
-- vim.opt.listchars = "tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»"

-- fix formatting (hard word wrap) in neovim>=0.8 and pylsp
vim.opt.formatexpr = "pylsp#Format()"

-- ### Colors (-> after/colors.lua )
vim.g.gruvbox_italic = true
vim.g.gruvbox_transparent_bg = true
vim.cmd('colorscheme gruvbox')
vim.cmd('hi Normal ctermbg=None')          -- transparent background

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

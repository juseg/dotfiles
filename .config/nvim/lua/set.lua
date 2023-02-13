-- ~/.config/nvim/lua/set.lua - Neovim settings ------------------------------

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

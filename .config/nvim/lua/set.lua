-- ~/.config/nvim/lua/set.lua - Neovim settings ------------------------------

-- turn off bell
vim.opt.belloff = 'all'

-- line numbers and newlines
vim.opt.linebreak = true        -- break line between words
vim.opt.number = true           -- enable line numbering
vim.opt.relativenumber = true   -- relative line numbers (testing)
vim.opt.cursorline = true       -- highlight current line
vim.opt.colorcolumn = "80"      -- color column 80 (pep8 limit)

-- default indentation
vim.opt.expandtab = true        -- tabs as spaces
vim.opt.tabstop = 4             -- length of tabs in display
vim.opt.softtabstop = 4         -- length of tabs in insert mode
vim.opt.shiftwidth = 4          -- used by < and >
vim.opt.smartindent = true      -- auto indent new lines
vim.opt.autoindent = false      -- a bit less auto than smartindent

-- replace backups by undodir (testing)
vim.opt.backup = false          -- no backup.file~
vim.opt.swapfile = false        -- no swapfile.swp
vim.opt.undodir = os.getenv('XDG_CACHE_HOME') .. '/nvim/undo/'
vim.opt.undofile = true         -- save undo tree to a file

-- searching
vim.opt.hlsearch = false        -- remove highlight after search
vim.opt.ignorecase = true       -- case-insensitive search
vim.opt.incsearch = true        -- search while typing
vim.opt.smartcase = true        -- uppercase-only-sensitive search

-- split and navigation
vim.opt.scrolloff = 8           -- always show 8 context lines
vim.opt.splitbelow = true       -- open splits below
vim.opt.splitright = true       -- open splits to the right

-- code folding
vim.opt.foldmethod = "indent"   -- fold by indentation
vim.opt.foldlevel = 99          -- files open unfolded

-- other
vim.opt.updatetime = 50         -- fast update for e.g. gitsigns
vim.opt.listchars = {           -- show spaces in list mode
    tab = '→~', space = '·', nbsp = '␣', trail = '•', eol = '¶',
    precedes = '«', extends = '»' }

-- Copyright (c) 2019-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/config/keymaps.lua - Key mappings ----------------------
--
-- After ThePrimeagen (https://www.youtube.com/watch?v=w7i4amO_zaE)

-- leader key
vim.g.mapleader = ' '

-- remap the mode key
vim.keymap.set('i', 'jj', '<esc>')

-- lint, execute and make
vim.keymap.set('n', '<F7>', '<cmd>!flake8 %<cr>') -- run flake8 on file
vim.keymap.set('n', '<F8>', '<cmd>!pylint %<cr>') -- run pylint on file
vim.keymap.set('n', '<F9>', '<cmd>!%:p<cr>') -- execute current file
vim.keymap.set('n', '<F10>', '<cmd>!chmod +x %<cr>', { silent = true })
vim.keymap.set('n', '<F12>', '<cmd>!make<cr>') -- run make

-- split navigation
vim.keymap.set('n', '<C-h>', '<C-W>h') -- move to split left
vim.keymap.set('n', '<C-j>', '<C-W>j') -- move to split below
vim.keymap.set('n', '<C-k>', '<C-W>k') -- move to split above
vim.keymap.set('n', '<C-l>', '<C-W>l') -- move to split right

-- quickfix nagivation
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz") -- next quickfix entry
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz") -- previous quickfix entry

-- buffer navigation
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- move up and center
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- move down and center

-- copy and paste
vim.keymap.set('n', '<leader>p', '"+p') -- paste from clipboard
vim.keymap.set('v', '<leader>p', '"_dP') -- paste and keep
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d') -- delete to void register
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y') -- yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>x', '"_x') -- delete to void register

-- other leader key mappings
vim.keymap.set('n', '<leader><leader>', '<cmd>so<cr>') -- source current file
vim.keymap.set('n', '<leader>e', vim.cmd.Ex) -- open file explorer
vim.keymap.set("n", "<leader>s", -- search and replace word under curser
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- reduce cursor motion
vim.keymap.set('n', 'J', 'mzJ`z') -- join lines without moving cursor
vim.keymap.set('n', 'n', 'nzzzv') -- search forward, center, and unfold
vim.keymap.set('n', 'N', 'Nzzzv') -- search backward, center, and unfold
vim.keymap.set('n', 'Q', '<nop>') -- disable repeat last register
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv") -- move selection down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv") -- move selection up

-- Copyright (c) 2019-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/lua/config/keymaps.lua - Key mappings ----------------------
--
-- After ThePrimeagen (https://www.youtube.com/watch?v=w7i4amO_zaE)

-- leader key
vim.g.mapleader = ' '

-- remap the mode key
vim.keymap.set('i', 'jj', '<esc>', { desc = 'exit insert mode' })

-- actions on file
vim.keymap.set('n', '<leader><leader>', '<cmd>:w<cr><cmd>!%:p&<cr>', {
  desc = 'Write and exec' })
vim.keymap.set('n', '<leader>,', '<cmd>!%:p<cr>', { desc = 'Exec file' })
vim.keymap.set('n', '<leader>.', '<cmd>so<cr>', { desc = 'Source file' })
vim.keymap.set('n', '<leader>a', '<cmd>chmod +x %<cr>', {
  desc = 'Allow execution', silent = true })
vim.keymap.set('n', '<leader>b', '<cmd>!%:p&<cr>', { desc = 'Background exec' })
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Open explorer' })
vim.keymap.set('n', '<leader>l', '<cmd>!flake8 % && pylint %<cr>', {
  desc = 'Run flake8 and pylint' })
vim.keymap.set('n', '<leader>m', '<cmd>!make<cr>', { desc = 'Run make' })

-- split navigation
vim.keymap.set('n', '<C-h>', '<C-W>h', { desc = 'move to split left' })
vim.keymap.set('n', '<C-j>', '<C-W>j', { desc = 'move to split below' })
vim.keymap.set('n', '<C-k>', '<C-W>k', { desc = 'move to split above' })
vim.keymap.set('n', '<C-l>', '<C-W>l', { desc = 'move to split right' })

-- split resizing
vim.keymap.set('n', '<C-H>', '<cmd>vert res -4<cr>', { desc = 'Narrow window' })
vim.keymap.set('n', '<C-J>', '<cmd>resize -4<cr>', { desc = 'Shorten window' })
vim.keymap.set('n', '<C-K>', '<cmd>resize +4<cr>', { desc = 'Grow window' })
vim.keymap.set('n', '<C-L>', '<cmd>vert res +4<cr>', { desc = 'Widen window' })

-- quickfix nagivation
vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>zz', { desc = 'Next quickfix' })
vim.keymap.set('n', '<C-p>', '<cmd>cprev<CR>zz', { desc = 'Previous quickfix' })

-- buffer navigation
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up and center' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down and center' })

-- copy and paste
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from system' })
vim.keymap.set('v', '<leader>p', '"_dP', { desc = 'Paste and keep' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete to void' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system' })
vim.keymap.set({ 'n', 'v' }, '<leader>x', '"_x', { desc = 'Delete to void' })

-- other leader key mappings
vim.keymap.set('n', '<leader>s',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Replace current word' })

-- reduce cursor motion
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines without moving' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Search forward and center' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Search backward and center' })
vim.keymap.set('n', 'Q', '<nop>', { desc = 'Disable repeat last register' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

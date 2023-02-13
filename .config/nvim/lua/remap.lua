-- ~/.config/nvim/lua/remap.lua - Key mappings -------------------------------

-- remap the mode key
vim.keymap.set('i', 'jj', '<esc>')

-- lint, execute and make shortcuts
vim.keymap.set('n', '<F7>', '<cmd>!flake8 %<cr>')   -- run flake8 on file
vim.keymap.set('n', '<F8>', '<cmd>!pylint %<cr>')   -- run pylint on file
vim.keymap.set('n', '<F9>', '<cmd>!%:p<cr>')        -- execute current file
vim.keymap.set('n', '<F12>', '<cmd>!make<cr>')      -- run make

-- commenting python code in visual mode
-- (FIXME broken, consider nvim-comment)
-- vim.keymap.set('v', 'cc', '<cmd>s/^/#/<cr>:noh<cr>|')   -- insert starting #
-- vim.keymap.set('v', 'cx', '<cmd>s/^#//<cr>:noh<cr>|')   -- remove starting #

-- split navigation
vim.keymap.set('n', '<C-J>', '<C-W><C-H>')  -- move to the split to the left
vim.keymap.set('n', '<C-K>', '<C-W><C-J>')  -- move to the split below
vim.keymap.set('n', '<C-I>', '<C-W><C-K>')  -- move to the split above
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')  -- move to the split to the right

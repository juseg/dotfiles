-- ~/.config/nvim/lua/nordic.lua - Nordic tweaks -----------------------------

-- insert square, commands (remap=true needed for buffer remaps)
vim.keymap.set({ 'i', 'l', 'n', 'v' }, 'ø', '[', { remap = true })
vim.keymap.set({ 'i', 'l', 'n', 'v' }, 'æ', ']', { remap = true })

-- insert curls, paragraph navigation
vim.keymap.set({ 'i', 'l', 'n', 'v' }, 'Ø', '{')
vim.keymap.set({ 'i', 'l', 'n', 'v' }, 'Æ', '}')

-- use alt key to type actual characers
vim.keymap.set({ 'i', 'l', 'n', 'v' }, '<A-ø>', 'ø')
vim.keymap.set({ 'i', 'l', 'n', 'v' }, '<A-æ>', 'æ')
vim.keymap.set({ 'i', 'l', 'n', 'v' }, '<A-Ø>', 'Ø')
vim.keymap.set({ 'i', 'l', 'n', 'v' }, '<A-Æ>', 'Æ')

-- section navigation
vim.keymap.set({ 'n', 'v' }, 'øø', '[[')
vim.keymap.set({ 'n', 'v' }, 'øæ', '[]')
vim.keymap.set({ 'n', 'v' }, 'æø', '][')
vim.keymap.set({ 'n', 'v' }, 'ææ', ']]')

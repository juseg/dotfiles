

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

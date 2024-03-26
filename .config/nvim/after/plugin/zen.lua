-- ~/.config/nvim/after/plugin/zen.lua - Zen mode ----------------------------

-- configure neovim zen mode
require("zen-mode").setup {
    window = {
        width = 96, -- width of the zen window (chars, fraction or function)
        height = 0.8, -- height of the zen window (chars, fraction or function)
        options = {
            colorcolumn = "0", -- disable color column
            cursorline = false, -- disable cursor line
            relativenumber = false, -- disable numbers
            signcolumn = "no", -- disable signcolumn
        },
    },
    -- disable autocompletion
    on_open = function()
        require('cmp').setup.buffer { enabled = false }
    end,
    on_close = function()
        require('cmp').setup.buffer { enabled = true }
        vim.cmd.quit{mods={confirm=true}}
    end,
}

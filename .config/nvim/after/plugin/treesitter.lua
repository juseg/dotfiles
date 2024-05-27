-- ~/.config/nvim/after/plugin/treesitter.lua - Language parsing -------------

require 'nvim-treesitter.configs'.setup {

    -- listed parsers should always be installed
    ensure_installed = { 'lua', 'python', 'vimdoc' },

    -- automatically install missing parsers when entering buffer
    auto_install = true,

    -- setting to `false` will disable the whole extension
    highlight = { enable = true },

}

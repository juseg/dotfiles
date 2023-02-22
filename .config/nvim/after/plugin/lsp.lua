-- ~/.config/nvim/after/plugin/lsp.lua - Autocompletion and LSP --------------
--
-- After ThePrimeagen (https://www.youtube.com/watch?v=w7i4amO_zaE)

-- load lsp-zero preset
local lsp = require('lsp-zero').preset()

-- fix undefined global vim
lsp.configure('lua_ls', {
    settings = { Lua = { diagnostics = { globals = { 'vim' } } } } })

-- enable pylint
lsp.configure('pylsp', {
    settings = { pylsp = { plugins = { pylint = { enabled = true } } } } })

-- configure servers if installed (list at ~/.local/share/nvim/site/pack/\
-- packer/start/nvim-lspconfig/doc/server_configurations.md)
lsp.setup_servers({ 'cssls', 'html', 'lua_ls', 'marksman', 'pylsp', 'texlab' })

-- setup needs to come after configure
lsp.setup()

-- diagnostics as virtual text (needs to come after setup)
vim.diagnostic.config({ virtual_text = true })

-- override cmp configuration (instead of using lsp.setup_nvim_cmp)
local cmp = require 'cmp'
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup(lsp.defaults.cmp_config({
    -- navigate suggestions
    mapping = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    -- appearance (not supported by lsp.setup_nvim_cmp)
    experimental = { ghost_text = true },
    window = { completion = cmp.config.window.bordered() },
}))

-- additional keys on lsp-attached buffers (see nvim-lspconfig readme)
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
end)

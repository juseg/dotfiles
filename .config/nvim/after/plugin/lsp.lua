-- ~/.config/nvim/after/plugin/lsp.lua - Autocompletion and LSP --------------
--
-- After ThePrimeagen (https://www.youtube.com/watch?v=w7i4amO_zaE)

-- load lsp-zero preset
local lsp = require('lsp-zero').preset()
lsp.setup()

-- configure servers if installed (list at ~/.local/share/nvim/site/pack/\
-- packer/start/nvim-lspconfig/doc/server_configurations.md)
lsp.setup_servers({'cssls', 'html', 'lua_ls', 'marksman', 'pylsp', 'texlab'})

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

-- additional keys on current buffer if it uses lsp
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
end)

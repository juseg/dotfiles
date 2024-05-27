-- Copyright (c) 2013-2024, Julien Seguinot (juseg.dev)
-- GNU General Public License v3.0+ (https://www.gnu.org/licenses/gpl-3.0.txt)
--
-- ~/.config/nvim/init.lua - Neovim configuration file using lua script

-- FIXME move to config/*.lua as in lazyvim?
require('autocmd') -- automatic commands
require('nordic') -- nordic tweaks
require('remap') -- key mappings
require('set') -- neovim settings

-- bootstrap lazy (see https://github.com/folke/lazy.nvim#-installation)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--branch=stable', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- load specs (https://github.com/folke/lazy.nvim#-structuring-your-plugins)
require('lazy').setup('plugins')

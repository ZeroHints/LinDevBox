-- Options & Variables
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.spell = false
vim.opt.signcolumn = "auto"
vim.opt.wrap = false

vim.g.mapleader = " "
vim.g.maplocalleader = ' '
vim.g.autoformat_enabled = true
vim.g.cmp_enabled = true
vim.g.autopairs_enabled = true
vim.g.diagnostics_mode = 3
vim.g.icons_enabled = true
vim.g.ui_notifications_enabled = true

-- Plugins

-- Install package manager
--    https://github.com/folke/lazy.nvim --    `:help lazy.nvim.txt` for more info
local lazyDirPath = vim.fn.stdpath('data')..'/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazyDirPath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazyDirPath,
  })
end
vim.opt.rtp:prepend(lazyDirPath)

require('lazy').setup({})
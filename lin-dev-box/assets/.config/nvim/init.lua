-- Plugins
-- Install plugins manager (https://github.com/folke/lazy.nvim) `:help lazy.nvim.txt` for more info
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

require('lazy').setup({
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
      }
    }
  },
  {
    'folke/which-key.nvim', -- Useful plugin to show you pending keybinds.
    opts = {}
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
})

-- Options & Variables
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.spell = false
vim.opt.signcolumn = "auto"
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
vim.opt.hlsearch = false -- Highlight on search
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.smartcase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease update time
vim.opt.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.opt.termguicolors = true -- NOTE: You should make sure your terminal supports this

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.autoformat_enabled = true
vim.g.cmp_enabled = true
vim.g.autopairs_enabled = true
vim.g.diagnostics_mode = 3
vim.g.icons_enabled = true
vim.g.ui_notifications_enabled = true

vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = 0


-- Mappings

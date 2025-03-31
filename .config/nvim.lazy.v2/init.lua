-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require('config.lazy')
require('config.options')
require('config.keymaps')
require('config.commands')
require('config.autocmds')

-- setup must be called before loading
vim.api.nvim_command('colorscheme  xcodedark')

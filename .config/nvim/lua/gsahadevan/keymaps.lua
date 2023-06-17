-- Modes
-- n - normal_mode
-- i - insert_mode
-- v - visual_mode
-- x - visual_block_mode
-- t - term_mode (terminal)
-- c - command_mode

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set -- Shorten function name

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('n', '<leader>a', 'gg<S-v>G', { noremap = true, silent = true, desc = 'Select all text in buffer' })
keymap('n', '<leader>nh', ':nohl<CR>', { noremap = true, silent = true, desc = 'No (Remove) search highlighting' })

-- Split window
keymap('n', 'sv', ':vsplit<Return><C-w>w', { noremap = true, silent = true, desc = 'Split current window vertically' })
keymap('n', 'ss', ':split<Return><C-w>w', { noremap = true, silent = true, desc = 'Split current window horizontally' })
keymap('n', 'se', '<C-w>=', { noremap = true, silent = true, desc = 'Make all windows equal size' })
keymap('n', 'sw', ':close<CR>', { noremap = true, silent = true, desc = 'Close current window' })

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Stay in visual mode while indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Diagnostics --
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diagnostic goto prev' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Diagnostic goto next' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diagnostic open float window' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic set loc list' })

-- Terminal --
-- Some other options are
-- :topleft split | terminal or :vsplit | terminal or :split | resize 20 | term
keymap('n', '<c-\\>', ':belowright split | resize 15 | terminal<cr>', { desc = 'Open terminal window' })

-- Better terminal navigation
local term_opts = { silent = true }
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

keymap('n', 'J', 'mzJ`z')          -- keeps cursor in place when joining lines
keymap('n', '<C-d>', '<C-d>zz')    -- keeps cursor in the middle of screen
keymap('n', '<C-u>', '<C-u>zz')    -- keeps cursor in the middle of screen
keymap('n', 'n', 'nzzzv')          -- keeps cursor in the middle for search terms
keymap('n', 'N', 'Nzzzv')          -- keeps cursor in the middle for search terms
keymap('x', '<leader>pp', '\'_dp') -- preserve pasted in buffer
keymap('n', 'x', '"_x')            -- do not save characters cut using x

-- pressing leaderY would enabled further yanking to save yanked text to clipboard
keymap('n', '<leader>y', '\'+y')
keymap('v', '<leader>y', '\'+y')
keymap('n', '<leader>Y', '\'+Y')

keymap('n', '<leader>d', '\'_d')
keymap('v', '<leader>d', '\'_d')
keymap('v', '<leader>d', '\'_d')

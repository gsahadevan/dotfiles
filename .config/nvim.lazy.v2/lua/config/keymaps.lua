-- ╭───────────────────────────────────╮
-- │ Add keymaps                       │
-- ╰───────────────────────────────────╯

-- Modes reference
-- n - normal_mode | i - insert_mode | v - visual_mode | x - visual_block_mode | t - term_mode (terminal) | c - command_mode

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set -- Shorten function name

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Buffers
keymap('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Buffer next' })
keymap('n', '<s-tab>', '<cmd>bprevious<cr>', { desc = 'Buffer prev' })
keymap('n', '<leader>w', '<cmd>bdelete<cr> <bar> <cmd>bprevious<cr>', { desc = 'Buffer close' })
-- keymap('n', '<leader>q', '<cmd>%bdelete<cr> <bar> <cmd>edit#<cr>', { desc = 'Buffer close others' }) -- alternatively :%bd|e#
keymap('n', '<leader>q', '<cmd>CustomCloseOtherBuffers<cr>', { desc = 'Buffer close others' }) -- alternatively :%bd|e#
keymap('n', '<leader>Q', '<cmd>CustomCloseAllBuffers<cr>', { desc = 'Buffer close all' })
keymap('n', '<leader>W', '<cmd>bdelete!<cr> <bar> <cmd>bprevious<cr>', { desc = 'Buffer force close' })

-- Windows
keymap('n', 'sv', '<cmd>vsplit<cr><c-w>w', { noremap = true, silent = true, desc = 'Window split current vertically' })
keymap('n', 'ss', '<cmd>split<cr><c-w>w', { noremap = true, silent = true, desc = 'Window split current horizontally' })
keymap('n', 'sw', '<cmd>close<cr>', { noremap = true, silent = true, desc = 'Window close current' })
keymap('n', 'sr', '<c-w><c-r>', { noremap = true, silent = true, desc = 'Window swap position' })

-- Windows re-sizing
keymap('n', 'se', '<c-w>=', { noremap = true, silent = true, desc = 'Window make all equal size' })
keymap('n', 'sz', '<c-w>_ | <c-w>|', { noremap = true, silent = true, desc = 'Window zoom current split' })
keymap('n', '<c-w>.', '<c-w>5>', { noremap = true, silent = true, desc = 'Window increase width' })
keymap('n', '<c-w>,', '<c-w>5<', { noremap = true, silent = true, desc = 'Window decrease width' })
keymap('n', '<c-w>t', '<c-w>+', { noremap = true, silent = true, desc = 'Window increase height' })
keymap('n', '<c-w>s', '<c-w>-', { noremap = true, silent = true, desc = 'Window decrease height' })

-- Selection and highlighting
keymap('n', '<leader>a', 'gg<S-v>G', { noremap = true, silent = true, desc = 'Select all text in buffer' })
keymap('n', '<esc>', '<cmd>nohl<cr>', { noremap = true, silent = true, desc = 'No (Remove) search highlighting' })

-- Stay in visual mode while indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move visually selected text up and down
keymap('v', 'J', ':m \'>+1<cr>gv=gv', opts) -- in normal mode J -> joins lines
keymap('v', 'K', ':m \'<-2<cr>gv=gv', opts) -- in normal mode K -> LSP show hover doc
-- keymap('n', '<leader>tt', ':belowright split | resize 15 | terminal<cr>', { desc = 'Open terminal window' }) -- Some other options are :topleft split | terminal or :vsplit | terminal or :split | resize 20 | term
keymap('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Exit terminal mode (enter normal mode on terminal) with esc' }) -- Easily hit escape in terminal mode

-- Open terminal at the bottom of the screen with a fixed height
-- Does the same as <leader>tt before
local term_id = 0
keymap('n', '<leader>tt', function()
    vim.cmd.new()
    vim.cmd.wincmd('J')
    vim.api.nvim_win_set_height(0, 15)
    vim.wo.winfixheight = true
    vim.cmd.term()
    term_id = vim.bo.channel
end)

-- Send commands to terminal
keymap('n', '<leader>ttt', function()
    vim.fn.chansend(term_id, { "pnpm test\r" })
end, { desc = 'Run tests in terminal' })

-- Command mode
keymap('c', 'Q', 'q')   -- replace Q with q on the command mode
keymap('c', 'Qa', 'qa') -- replace Qa with qa on the command mode

-- Misc
-- keymap('n', '<leader>pv', vim.cmd.Explore, { desc = 'Open Netrw directory listing' })
keymap('n', '<leader>pv', '<cmd>:Oil<cr>', { desc = 'Open oil directory listing' })
keymap('n', 'cp', '<cmd>let @+ = expand("%p")<cr>', { desc = 'Copy absolute file path' })
keymap('n', ',f', '<cmd>%s/"/\'/g<cr>', { desc = 'Format replace " with \'' })

-- Position of the cursor relative to the screen
-- cnoremap <expr> <CR> getcmdtype() == '/' ? '<CR>zz' : '<CR>' -- can also be done using this command
keymap('c', '<cr>', function()
    return vim.fn.getcmdtype() == '/' and '<cr>zz' or '<cr>'
end, { expr = true, desc = 'Keeps cursor in the middle of the screen on first occurrence of next search match' })
-- cnoremap <expr> <CR> getcmdtype() == '?' ? '<CR>zz' : '<CR>' -- can also be done using this command
keymap('c', '<cr>', function()
    return vim.fn.getcmdtype() == '?' and '<cr>zz' or '<cr>'
end, { expr = true, desc = 'Keeps cursor in the middle of the screen on first occurrence of previous search match' })
keymap('n', '*', function() vim.cmd('normal! *zz') end, { desc = 'Keeps cursor in the middle on next occurrence' })
keymap('n', '#', function() vim.cmd('normal! #zz') end, { desc = 'Keeps cursor in the middle on previous occurrence' })
keymap('n', 'n', 'nzzzv', { desc = 'Keeps cursor in the middle for next occurrence of search terms' })
keymap('n', 'N', 'Nzzzv', { desc = 'Keeps cursor in the middle for previosu occurence of search terms' })
keymap('n', 'J', 'mzJ`z', { desc = 'Keeps cursor in place when joining lines' })
keymap('n', '<c-d>', '<c-d>zz', { desc = 'Keeps cursor in the middle of screen' })
keymap('n', '<c-u>', '<c-u>zz', { desc = 'Keeps cursor in the middle of screen' })

-- Preserve pasted in buffer
keymap('v', '<leader>p', '"_dp', { desc = 'Preserve pasted in buffer - visual mode' })
keymap('x', '<leader>p', '"_dp', { desc = 'Preserve pasted in buffer - visual block mode' })
keymap('n', 'x', '"_x', { desc = 'Do not save characters cut using x' })

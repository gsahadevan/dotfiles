-- Modes
-- n - normal_mode
-- i - insert_mode
-- v - visual_mode
-- x - visual_block_mode
-- t - term_mode (terminal)
-- c - command_mode

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('n', '<leader>a', 'gg<S-v>G', { noremap = true, silent = true, desc = 'Select all text in buffer' })
keymap('n', '<leader>nh', ':nohl<CR>', { noremap = true, silent = true, desc = 'No (Remove) search highlighting' })

-- Save with root permission (not working for now)
-- vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab | opting for buffers instead of tabs
-- keymap('n', 'te', ':tabedit<CR>', opts)
-- keymap('n', 'tt', ':tabnew<CR>', opts)
-- keymap('n', 'tp', ':tabprevious<CR>', opts)
-- keymap('n', 'tn', ':tabnext<CR>', opts)
-- keymap('n', 'tc', ':tabclose<CR>', opts)

-- Split window
keymap('n', 'sv', ':vsplit<Return><C-w>w', { noremap = true, silent = true, desc = 'Split current window vertically' })
keymap('n', 'ss', ':split<Return><C-w>w', { noremap = true, silent = true, desc = 'Split current window horizontally' })
keymap('n', 'se', '<C-w>=', { noremap = true, silent = true, desc = 'Make all windows equal size' })
keymap('n', 'sw', ':close<CR>', { noremap = true, silent = true, desc = 'Close current window' })

-- Increment and Decrement numbers
-- One would rather use ctrl + a instead of space, then shift + over and over again
-- keymap('n', '<leader>+', '<C-a>', opts)
-- keymap('n', '<leader>-', '<C-x>', opts)

-- Move window
-- Hard to use this combination when in terminal mode
-- So might as well use ctrl + w and j and k | ctrl + h and l are working below
-- keymap.set('n', '<Space>', '<C-w>w')
-- keymap('n', 'sh', '<C-w>h')
-- keymap('n', 'sk', '<C-w>k')
-- keymap('n', 'sj', '<C-w>j')
-- keymap('n', 'sl', '<C-w>l')

-- Resize window
-- keymap('n', '<C-w><left>', '<C-w><')
-- keymap('n', '<C-w><right>', '<C-w>>')
-- keymap('n', '<C-w><up>', '<C-w>+')
-- keymap('n', '<C-w><down>', '<C-w>-')

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
-- keymap('n', '<C-j>', '<C-w>j', opts) -- does not work, defaults to join
-- keymap('n', '<C-k>', '<C-w>k', opts) -- does not work, defaults to show signature_help (more useful that way)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows | mapped with workspaces navigation
-- ctrl + up arrow messes with mac os default show spaces
-- keymap('n', '<C-Up>', ':resize -1<CR>', opts)
-- keymap('n', '<C-Down>', ':resize +3<CR>', opts)
-- keymap('n', '<C-Left>', ':vertical resize -1<CR>', opts)
-- keymap('n', '<C-Right>', ':vertical resize +3<CR>', opts)

-- Navigate buffers
-- keymap('n', '<S-l>', ':bnext<CR>', opts)
-- keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Move text up and down
-- keymap('n', '<A-j>', '<cmd>:m .+2<CR>==gi', opts) -- works
-- keymap('n', '<A-k>', '<cmd>:m .-1<CR>==gi', opts) -- doesn't work

-- Insert --
-- Press jk fast to exit insert mode
-- keymap('i', 'jk', '<ESC>', opts)
-- keymap('i', 'kj', '<ESC>', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and down
-- keymap('v', '<A-j>', ':m .+2<CR>==', opts)
-- keymap('v', '<A-k>', ':m .-1<CR>==', opts)
keymap('v', 'p', '"_dP', opts)

-- Visual Block --
-- Move text up and down
-- keymap('x', 'J', ":move '>+2<CR>gv-gv", opts)
-- keymap('x', 'K', ":move '<-1<CR>gv-gv", opts)
-- keymap('x', '<A-j>', ":move '>+2<CR>gv-gv", opts)
-- keymap('x', '<A-k>', ":move '<-1<CR>gv-gv", opts)

-- Diagnostics --
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diagnostic goto prev' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Diagnostic goto next' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diagnostic open float window' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic set loc list' })

-- Terminal --
-- Better terminal navigation
vim.keymap.set('n', '<c-\\>', ':belowright split | resize 10 | terminal<cr>', { desc = 'Open terminal window' })
local term_opts = { silent = true }
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)
-- :belowright split | terminal
-- :topleft split | terminal
-- :split | terminal
-- :vsplit | terminal
-- :split | resize 20 | term


-- the primeagen
-- vim.keymap.set('v', 'J', ':m '>+2<CR>gv=gv')
-- vim.keymap.set('v', 'K', ':m '<-1<CR>gv=gv')

vim.keymap.set('n', 'J', 'mzJ`z')          -- keeps cursor in place when joining lines
vim.keymap.set('n', '<C-d>', '<C-d>zz')    -- keeps cursor in the middle of screen
vim.keymap.set('n', '<C-u>', '<C-u>zz')    -- keeps cursor in the middle of screen
vim.keymap.set('n', 'n', 'nzzzv')          -- keeps cursor in the middle for search terms
vim.keymap.set('n', 'N', 'Nzzzv')          -- keeps cursor in the middle for search terms
vim.keymap.set('x', '<leader>pp', '\'_dp') -- preserve pasted in buffer
vim.keymap.set('n', 'x', '"_x')            -- do not save characters cut using x

-- pressing leaderY would enabled further yanking to save yanked text to clipboard
vim.keymap.set('n', '<leader>y', '\'+y')
vim.keymap.set('v', '<leader>y', '\'+y')
vim.keymap.set('n', '<leader>Y', '\'+Y')

vim.keymap.set('n', '<leader>d', '\'_d')
vim.keymap.set('v', '<leader>d', '\'_d')
vim.keymap.set('v', '<leader>d', '\'_d')

-- code navigation shortcuts, check :help lsp for more details
-- local opts = { noremap = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap
-- keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
-- keymap('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>', opts)
-- keymap('n', '<c-]>', ':lua vim.lsp.buf.declaration()<CR>', opts)
-- keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
-- keymap('n', 'gD', ':lua vim.lsp.buf.type_definition()<CR>', opts)
-- keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
-- keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
-- keymap('n', 'g0', ':lua vim.lsp.buf.document_symbol()<CR>', opts)
-- keymap('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>', opts)
-- code actions
-- keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)

-- goto previous/next diagnostic warning/error
-- keymap('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>', opts)
-- keymap('n', ']d', ':lua vim.diagnostic.goto_next()<CR>', opts)
-- keymap('n', 'gl', ':lua vim.diagnostic.open_float()<CR>', opts)

-- local set_hl_for_floating_window = function()
--     vim.api.nvim_set_hl(0, 'NormalFloat', {
--         link = 'Normal',
--     })
--     vim.api.nvim_set_hl(0, 'FloatBorder', {
--         bg = 'none',
--     })
-- end
-- set_hl_for_floating_window()
-- vim.api.nvim_create_autocmd('ColorScheme', {
--     pattern = '*',
--     desc = 'Avoid overwritten by loading color schemes later',
--     callback = set_hl_for_floating_window,
-- })

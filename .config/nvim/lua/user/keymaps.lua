local options = { noremap = true, silent = true }
-- local terminal_options = { silent = true }

-- shorten function name
local keymap = vim.api.nvim_set_keymap

-- remap space as leader key
keymap("", "<Space>", "<Nop>", options)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- modes
--  normal_mode = "n" | term_mode = "t",
--  visual_mode = "v" | visual_block_mode = "x",
--  insert_mode = "i" | command_mode = "c",

-- open lexplore on the left
keymap('n', '<leader>b', ':Lex 30<CR>', options)

-- use jk to exit insert mode
keymap("i", "jk", "<ESC>", options)

-- clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>", options)

-- delete single character without copying into register
keymap("n", "x", '"_x', options)

-- do not yank the replaced word
keymap("v", "p", '"_dP', options)

-- increment/decrement numbers
keymap("n", "<leader>+", "<C-a>", options) -- increment
keymap("n", "<leader>-", "<C-x>", options) -- decrement

-- window navigation
keymap("n", "<C-h>", "<C-w>h", options)
keymap("n", "<C-j>", "<C-w>j", options)
keymap("n", "<C-k>", "<C-w>k", options)
keymap("n", "<C-l>", "<C-w>l", options)

-- window management
keymap("n", "<leader>sv", "<C-w>v", options) -- split window vertically
keymap("n", "<leader>sh", "<C-w>s", options) -- split window horizontally
keymap("n", "<leader>se", "<C-w>=", options) -- make split windows equal width & height
keymap("n", "<leader>sx", ":close<CR>", options) -- close current split window

keymap("n", "<leader>to", ":tabnew<CR>", options) -- open new tab
keymap("n", "<leader>tx", ":tabclose<CR>", options) -- close current tab
keymap("n", "<leader>tn", ":tabn<CR>", options) --  go to next tab
keymap("n", "<leader>tp", ":tabp<CR>", options) --  go to previous tab

-- resize window with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", options)
keymap("n", "<C-Down>", ":resize -2<CR>", options)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", options)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", options)

-- stay in indent mode
keymap("v", "<", "<gv", options)
keymap("v", ">", ">gv", options)

-- move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", options)
keymap("v", "<A-k>", ":m .-2<CR>==", options)


-- move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", options)
keymap("x", "K", ":move '<-2<CR>gv-gv", options)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", options)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", options)

-- better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", terminal_options)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", terminal_options)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", terminal_options)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", terminal_options)


-- do not run the below commands if telescope is not installed
local status, _ = pcall(require, "telescope")
if not status then 
	return
end

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fc", builtin.grep_string, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- telescope git commands
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
vim.keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]


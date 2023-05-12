-- Normal Mode
--
-- `gcc` - Toggles the current line using linewise comment
-- `gbc` - Toggles the current line using blockwise comment
-- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
-- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
-- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
-- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
--
-- `gco` - Insert comment to the next line and enters INSERT mode
-- `gcO` - Insert comment to the previous line and enters INSERT mode
-- `gcA` - Insert comment to end of the current line and enters INSERT mode

-- Visual Mode
--
-- `gc` - Toggles the region using linewise comment
-- `gb` - Toggles the region using blockwise comment

-- Examples
-- # Linewise
--
-- `gcw` - Toggle from the current cursor position to the next word
-- `gc$` - Toggle from the current cursor position to the end of line
-- `gc}` - Toggle until the next blank line
-- `gc5j` - Toggle 5 lines after the current cursor position
-- `gc8k` - Toggle 8 lines before the current cursor position
-- `gcip` - Toggle inside of paragraph
-- `gca}` - Toggle around curly brackets

-- # Blockwise
--
-- `gb2}` - Toggle until the 2 next blank line
-- `gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
-- `gbac` - Toggle comment around a class (w/ LSP/treesitter support)

local _, cokeline = pcall(require, 'cokeline')
if cokeline then
    vim.api.nvim_set_keymap('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
    vim.api.nvim_set_keymap('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>p', '<Plug>(cokeline-switch-prev)', { silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>n', '<Plug>(cokeline-switch-next)', { silent = true })
end

local _, vim_bbye = pcall(require, 'vim-bbye')
if vim_bbye then
    vim.api.nvim_set_keymap('n', '<leader>w', ':Bdelete<CR>', { noremap = true, silent = true })
end

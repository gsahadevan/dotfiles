-- ╭───────────────────────────────────╮
-- │ Add autocommands                  │
-- ╰───────────────────────────────────╯

-- Automatically source and re-compile packer whenever you save this init.lua
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = vim.api.nvim_create_augroup('Packer', { clear = true }),
    pattern = vim.fn.expand '$MYVIMRC',
})

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
    pattern = '*',
    command = 'set nopaste'
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('CustomTermOpen', {}),
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.opt.scrolloff = 0
        vim.wo.cursorline = false
        vim.wo.cursorcolumn = false
        vim.wo.foldcolumn = '0'
        vim.wo.list = false
        vim.wo.signcolumn = 'no'
        vim.wo.wrap = false
    end,
})

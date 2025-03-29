vim.api.nvim_create_autocmd('InsertLeave', {
    pattern = '*',
    command = 'set nopaste',
    desc = 'Turn off paste mode when leaving insert',
})

vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = 'Highlight on yank',
})

-- vim.api.nvim_create_autocmd({ 'TermOpen' }, {
--     pattern = { '*' },
--     group = vim.api.nvim_create_augroup('term_settings', { clear = true }),
--     callback = function()
--         vim.api.nvim_command('set norelativenumber nonumber')
--     end,
--     desc = 'Terminal has no line numbers',
-- })

-- vim.api.nvim_create_autocmd({ 'TermOpen' }, {
--     pattern = { '*' },
--     group = vim.api.nvim_create_augroup('term_settings', { clear = true }),
--     command = 'startinsert',
--     desc = 'Go to insert mode when terminal opens',
-- })

-- code navigation shortcuts, check :help lsp for more details
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "<c-k>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "<c-]>", ":lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gD", ":lua vim.lsp.buf.type_definition()<CR>", opts)
keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "g0", ":lua vim.lsp.buf.document_symbol()<CR>", opts)
keymap("n", "gW", ":lua vim.lsp.buf.workspace_symbol()<CR>", opts)

-- goto previous/next diagnostic warning/error
keymap("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", opts)
keymap("n", "gl", ":lua vim.diagnostic.open_float()<CR>", opts)


local set_hl_for_floating_window = function()
    vim.api.nvim_set_hl(0, 'NormalFloat', {
        link = 'Normal',
    })
    vim.api.nvim_set_hl(0, 'FloatBorder', {
        bg = 'none',
    })
end
set_hl_for_floating_window()
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    desc = 'Avoid overwritten by loading color schemes later',
    callback = set_hl_for_floating_window,
})

local highlight_folder = function()
    vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = 'orange' })
    vim.api.nvim_set_hl(0, 'NvimTreeFolderName', { fg = 'white' })
    vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderName', { fg = 'white' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#21252b' })
end
highlight_folder()
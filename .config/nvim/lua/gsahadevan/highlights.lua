vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 0
vim.opt.pumheight = 15 -- completion height, adds scrollbar
vim.opt.pumwidth = 50  -- completion width
vim.opt.background = 'dark'

-- local _border = 'single'
--
-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
--     vim.lsp.handlers.hover, {
--         border = _border
--     }
-- )
--
-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
--     vim.lsp.handlers.signature_help, {
--         border = _border
--     }
-- )
--
-- vim.diagnostic.config {
--     float = { border = _border }
-- }
--
-- require('lspconfig.ui.windows').default_options.border = 'single'
-- require('lspconfig.ui.windows').default_options = {
--     border = _border
-- }

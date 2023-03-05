local status, nvim_lspconfig = pcall(require, 'lspconfig')
if not status then
    print('nvim-lspconfig not installed')
    return
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- get the instance of completion and attach to lsp
-- add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lspconfig['tsserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
    cmd = { 'typescript-language-server', '--stdio' }
}

nvim_lspconfig['lua_ls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false
            },
        },
    },
}

-- change the default E, W, H and I indicators on the gutter to fancy icons
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- local on_attach = function(client, bufnr)
--     -- formatting
--     if client.server_capabilities.documentFormattingProvider then
--         vim.api.nvim_command [[augroup Format]]
--         vim.api.nvim_command [[autocmd! * <buffer>]]
--         vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
--         vim.api.nvim_command [[augroup END]]
--     end
-- end
--
-- nvim_lsp.tsserver.setup {
--     on_attach = on_attach,
--     filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
--     cmd = { 'typescript-language-server', '--stdio' }
-- }
--
-- nvim_lsp.tailwindcss.setup {
--     on_attach = on_attach,
--     cmd = { 'tailwindcss-language-server', '--stdio' }
-- }
--
-- nvim_lsp.sumneko_lua.setup {
--     on_attach = on_attach,
--     settings = {
--         Lua = {
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = { 'vim' }
--             },
--
--             workspace = {
--                 -- Make the server aware of Neovim runtime files
--                 library = vim.api.nvim_get_runtime_file('', true),
--                 checkThirdParty = false
--             },
--         },
--     },
-- }
--
-- local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
-- for type, icon in pairs(signs) do
--     local hl = 'DiagnosticSign' .. type
--     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

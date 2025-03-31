return {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = function()
            -- require("mason").setup()
            require('mason').setup({
                ui = {
                    border = 'rounded',
                    height = 0.95,
                    width = 0.95,
                }
            })
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "eslint" },
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        -- dependencies = { 'saghen/blink.cmp' },
        lazy = false,
        config = function()
            -- local capabilities = require("blink.cmp").get_lsp_capabilities()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })

            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    client.server_capabilities.document_formatting = false
                end,
            })

            lspconfig.eslint.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    client.server_capabilities.document_formatting = false
                end,
            })
        end,
    },
}

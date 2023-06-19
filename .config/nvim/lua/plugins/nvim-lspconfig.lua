return {
    {
        -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
        -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
        'folke/neodev.nvim',
        opts = {
            library = {
                enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
                -- these settings will be used for your Neovim config directory
                runtime = true, -- runtime path
                types = true,   -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                plugins = true, -- installed opt or start plugins in packpath
                -- you can also specify the list of plugins to make available as a workspace library
                -- plugins = { 'nvim-treesitter', 'plenary.nvim', 'telescope.nvim' },
            },
            setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
            -- for your Neovim config directory, the config.library settings will be used as is
            -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
            -- for any other directory, config.library.enabled will be set to false
            override = function(root_dir, options)
            end,
            -- With lspconfig, Neodev will automatically setup your lua-language-server
            -- If you disable this, then you have to set {before_init=require('neodev.lsp').before_init}
            -- in your lsp start options
            lspconfig = true,
            -- much faster, but needs a recent built of lua-language-server
            -- needs lua-language-server >= 3.6.0
            pathStrict = true,
        }
    },
    {
        'neovim/nvim-lspconfig', -- configurations for neovim LSP
        dependencies = {
            {
                'williamboman/mason-lspconfig.nvim',
                cmd = { 'LspInstall', 'LspUninstall' },
                config = function()
                    require('mason-lspconfig').setup {
                        -- A list of servers to automatically install if they're not already installed. Example: { 'rust_analyzer@nightly', 'lua_ls' }
                        -- This setting has no relation with the `automatic_installation` setting.
                        ---@type string[]
                        ensure_installed = {
                            'angularls',
                            'eslint',
                            'html',
                            'lua_ls',
                            'quick_lint_js',
                            'tailwindcss',
                            'tsserver'
                        },

                        -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
                        -- This setting has no relation with the `ensure_installed` setting.
                        -- Can either be:
                        --   - false: Servers are not automatically installed.
                        --   - true: All servers set up via lspconfig are automatically installed.
                        --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
                        --       Example: automatic_installation = { exclude = { 'rust_analyzer', 'solargraph' } }
                        ---@type boolean
                        automatic_installation = false,

                        -- See `:h mason-lspconfig.setup_handlers()`
                        ---@type table<string, fun(server_name: string)>?
                        handlers = nil,
                    }
                end
            },
            { 'ray-x/lsp_signature.nvim' },
            {
                -- renders diagnostics using virtual lines on top of the real line of code
                'Maan2003/lsp_lines.nvim',
                config = function()
                    require('lsp_lines').setup()
                    vim.diagnostic.config({ virtual_lines = true })
                    vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
                end
            },
        },
        config = function()
            -- local protocol = require('vim.lsp.protocol')

            local signs = require('../icons/font-icons')
            vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics,
                {
                    underline = true,
                    update_in_insert = false,
                    virtual_text = { spacing = 4, prefix = signs.TabClose },
                    severity_sort = true,
                    float = {
                        border = 'rounded',
                    }
                }
            )

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                {
                    border = 'rounded',
                    silent = true,
                }
            )

            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                {
                    border = 'rounded',
                    silent = true,
                }
            )

            -- Diagnostic symbols in the sign column (gutter)
            for type, icon in pairs(signs.DiagAlt2) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
            end

            vim.diagnostic.config({
                update_in_insert = true,
                virtual_text = { spacing = 4, prefix = signs.TabClose },
                float = {
                    border = 'rounded',
                    source = 'always', -- Or 'if_many'
                },
            })

            local augroup_format = vim.api.nvim_create_augroup('Format', { clear = true })
            local enable_format_on_save = function(_, bufnr)
                vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = augroup_format,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                })
            end

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            -- local on_attach = function(client, bufnr)
            local on_attach = function(_, _)
                -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

                -- Enable completion triggered by <c-x><c-o>
                -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
                -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                -- local opts = { noremap = true, silent = true }

                -- Using LspSaga with better UI implementation
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                -- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
                --     { noremap = true, silent = true, buffer = bufnr, desc = '' })
                -- vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>',
                --     { noremap = true, silent = true, buffer = bufnr, desc = '' })
                -- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>',
                --     { noremap = true, silent = true, buffer = bufnr, desc = '' })
                -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>',
                --     { noremap = true, silent = true, buffer = bufnr, desc = '' })
                -- vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>',
                --     { noremap = true, silent = true, buffer = bufnr, desc = '' })
                -- vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
                --     { noremap = true, silent = true, buffer = bufnr, desc = '' })
                -- vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>',
                --     { noremap = true, silent = true, buffer = bufnr, desc = '' })
                -- TODO - have to test attaching the keymaps here as well.
            end

            -- Set up completion using nvim_cmp with LSP source
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require('lspconfig')
            lspconfig.tsserver.setup {
                -- on_attach = on_attach,
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    enable_format_on_save(client, bufnr)
                end,
                filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
                cmd = { 'typescript-language-server', '--stdio' },
            }

            lspconfig.lua_ls.setup {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    enable_format_on_save(client, bufnr)
                end,
                settings = {
                    Lua = {
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file('', true),
                            checkThirdParty = false
                        },
                    },
                },
            }

            local servers = { 'angularls', 'eslint', 'html', 'quick_lint_js', 'tailwindcss' }
            for _, v in pairs(servers) do
                lspconfig[v].setup {
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        on_attach(client, bufnr)
                        enable_format_on_save(client, bufnr)
                    end,
                }
            end


            require('lspconfig.ui.windows').default_options.border = 'rounded'
            require('lspconfig.ui.windows').default_options = { border = 'rounded' }
            -- TODO: check the possibility of removing
            -- removed lsp_signature plugin in favour of cmp-nvim-lsp-signature-help
            require 'lsp_signature'.setup({
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                handler_opts = {
                    border = 'rounded',
                }
            })
        end
    },
}

-- mason-lspconfig bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins together.
--
-- :h mason-lspconfig-introduction

-- mason-lspconfig.nvim closes some gaps that exist between mason.nvim and lspconfig. Its main responsibilities are to:
--
-- register a setup hook with lspconfig that ensures servers installed with mason.nvim are set up with the necessary configuration
-- provide extra convenience APIs such as the :LspInstall command
-- allow you to (i) automatically install, and (ii) automatically set up a predefined list of servers
-- translate between lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
-- It is recommended to use this extension if you use mason.nvim and lspconfig (it's strongly recommended for Windows users).
--
-- Note: this plugin uses the lspconfig server names in the APIs it exposes - not mason.nvim package names. See this table for a complete mapping.
return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        -- 'neovim/nvim-lspconfig',
    },
    config = function()
        -- important information regarding setup
        -- :h mason-lspconfig-quickstart
        --
        -- It's important that you set up the plugins in the following order:
        --
        -- mason.nvim
        -- mason-lspconfig.nvim
        -- Setup servers via lspconfig
        -- Pay extra attention to this if you lazy-load plugins, or somehow 'chain' the loading of plugins via your plugin manager.
        require('mason').setup()
        require('mason-lspconfig').setup { -- A list of servers to automatically install if they're not already installed. Example: { 'rust_analyzer@nightly', 'lua_ls' }
            -- This setting has no relation with the `automatic_installation` setting.
            ensure_installed = {},

            -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
            -- This setting has no relation with the `ensure_installed` setting.
            -- Can either be:
            --   - false: Servers are not automatically installed.
            --   - true: All servers set up via lspconfig are automatically installed.
            --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
            --       Example: automatic_installation = { exclude = { 'rust_analyzer', 'solargraph' } }
            automatic_installation = true,

            -- See `:h mason-lspconfig.setup_handlers()`
            ---@type table<string, fun(server_name: string)>?
            handlers = nil,
        }
    end,
}

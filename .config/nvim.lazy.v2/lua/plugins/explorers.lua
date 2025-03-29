return {
    -- a file explorer for nvim written in lua
    {
        'nvim-tree/nvim-tree.lua',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        opts = {
            view = {
                centralize_selection = true,
                width = 55,
                preserve_window_proportions = true,
            },
            update_focused_file = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                icons = {
                    hint = '',
                    info = '',
                    warning = '',
                    error = '',
                },
            },
            modified = {
                enable = true,
            },
            filesystem_watchers = {
                enable = true,
                debounce_delay = 50,
                ignore_dirs = {
                    '.*/node_modules/.*',
                    '.git',
                    '.nx'
                },
            },
        },
        keys = {
            {'<leader>b', '<cmd>NvimTreeToggle<cr>', { desc = 'NvimTree toggle' }},
        },
    },
    -- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
}

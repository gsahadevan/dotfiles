return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'dracula',
            component_separators = '|',
            section_separators = '',
            disabled_filetypes = {
                statusline = { 'packer', 'NvimTree', 'mason' },
                winbar = { 'packer', 'NvimTree', 'mason' },
            },
            globalstatus = true,
        },
        sections = {
            lualine_b = { 'branch', 'diff' },
            lualine_c = {
                {
                    'diagnostics',
                    sections = { 'error', 'warn' },
                    symbols = {
                        error = '? ',
                        warn  = '? ',
                        info  = '? ',
                        hint  = '? ',
                    },
                },
            },
        },
        inactive_sections = {
            lualine_c = {},
        },
        tabline = {
            lualine_c = {
                {
                    'buffers',
                    mode = 0,                   -- 0: name, 1: index, 2: name + index, 3: number, 4: name + number
                    max_length = vim.o.columns, -- max_length = vim.o.columns * 2 / 3,
                    filetype_names = {
                        TelescopePrompt = 'Telescope',
                        dashboard = 'Dashboard',
                        packer = 'Packer',
                        fzf = 'FZF',
                        alpha = 'Alpha',
                        NvimTree = 'Explore',
                        netrw = 'Explore',
                    },
                    use_mode_colors = false,
                    buffers_color = {
                        active = { fg = 'black', bg = '#ca9ee6' },
                        inactive = {},
                    },
                },
            },
        },
    }
}

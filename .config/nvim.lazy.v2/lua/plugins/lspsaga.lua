return {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({
            border_style = 'rounded',
            ui = {
                border = 'rounded',
                kind = require('catppuccin.groups.integrations.lsp_saga').custom_kind(),
            },
            hover = {
                max_width = 0.6,
                max_height = 0.5,
            },
            finder = {
                max_height = 0.5,
                left_width = 0.3,
                default = 'tyd+ref+imp+def',
                keys = {
                    shuttle = '[w',
                    toggle_or_open = 'o',
                    vsplit = 's',
                    split = 'i',
                    tabe = 't',
                    tabnew = 'r',
                    quit = 'q',
                    close = '<C-c>k',
                },
            },
            symbol_in_winbar = {
                separator = ' ⮁ ',
                ignore_patterns = {},
                hide_keyword = true,
                show_file = true,
                folder_level = 6,
                respect_root = false,
                color_mode = true,
            },
        })
    end,
}

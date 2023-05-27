return {
    'glepnir/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
        require('lspsaga').setup({
            -- Options with default value
            -- 'single' | 'double' | 'rounded' | 'bold' | 'plus'
            border_style = 'single',
            --the range of 0 for fully opaque window (disabled) to 100 for fully
            --transparent background. Values between 0-30 are typically most useful.
            saga_winblend = 0,
            -- when cursor in saga window you config these to move
            move_in_saga = { prev = '<C-p>', next = '<C-n>' },
            -- Error, Warn, Info, Hint
            -- use emoji like
            -- { '🙀', '😿', '😾', '😺' }
            -- or
            -- { '😡', '😥', '😤', '😐' }
            -- and diagnostic_header can be a function type
            -- must return a string and when diagnostic_header
            -- is function type it will have a param `entry`
            -- entry is a table type has these filed
            -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
            -- diagnostic_header = { ' ', ' ', ' ', 'ﴞ ' }, -- default | gsahadevan uses the below line
            diagnostic_header = { ' ', ' ', ' ', ' ' },
            -- preview lines above of lsp_finder
            preview_lines_above = 0,
            -- preview lines of lsp_finder and definition preview
            max_preview_lines = 10,
            -- use emoji lightbulb in default
            -- code_action_icon = '💡', -- default | gsahadevan uses the below line
            code_action_icon = ' ',
            -- if true can press number to execute the codeaction in codeaction window
            code_action_num_shortcut = true,
            -- same as nvim-lightbulb but async
            code_action_lightbulb = {
                enable = true,
                enable_in_insert = true,
                cache_code_action = true,
                sign = true,
                update_time = 150,
                sign_priority = 20,
                virtual_text = true,
            },
            -- finder icons
            finder_icons = { def = '  ', ref = '諭 ', link = '  ' },
            -- finder do lsp request timeout
            -- if your project is big enough or your server very slow
            -- you may need to increase this value
            finder_request_timeout = 1500,
            -- finder_action_keys = {
            --     open = { 'o', '<CR>' },
            --     vsplit = 's',
            --     split = 'i',
            --     tabe = 't',
            --     quit = { 'q', '<ESC>' },
            -- },
            -- code_action_keys = {
            --     quit = 'q',
            --     exec = '<CR>',
            -- },
            -- definition_action_keys = {
            --     edit = '<C-c>o',
            --     vsplit = '<C-c>v',
            --     split = '<C-c>i',
            --     tabe = '<C-c>t',
            --     quit = 'q',
            -- },
            rename_action_quit = '<C-c>',
            rename_in_select = true,
            -- show symbols in winbar must nightly
            -- in_custom mean use lspsaga api to get symbols
            -- and set it to your custom winbar or some winbar plugins.
            -- if in_cusomt = true you must set in_enable to false
            -- symbol_in_winbar = {
            --     in_custom = false,
            --     enable = true,
            --     -- separator = '  ',
            --     separator = ' ⮁ ',
            --     show_file = true,
            --     -- define how to customize filename, eg: %:., %
            --     -- if not set, use default value `%:t`
            --     -- more information see `vim.fn.expand` or `expand`
            --     -- ## only valid after set `show_file = true`
            --     -- file_formatter = '%:p', -- full path
            --     -- file_formatter = '%:.',
            --     file_formatter = '%:., %',
            --     click_support = true,
            --     -- ignore_patterns = {},
            --     hide_keyword = true,  -- lspsaga will hide some keywords and tmp variables to make symbols look cleaner
            --     folder_level = 6,     -- show_file should be true
            --     respect_root = false, -- if this is true, lspsaga will ignore folder_level option
            --     color_mode = true,    -- when set to false, only icons will have color
            -- },
            -- show outline
            show_outline = {
                win_position = 'right',
                --set special filetype win that outline window split.like NvimTree neotree
                -- defx, db_ui
                win_with = '',
                win_width = 30,
                auto_enter = true,
                auto_preview = true,
                virt_text = '┃',
                jump_key = 'o',
                -- auto refresh when change buffer
                auto_refresh = true,
            },
            -- custom lsp kind
            -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
            custom_kind = {},
            -- if you don't use nvim-lspconfig you must pass your server name and
            -- the related filetypes into this table
            -- like server_filetype_map = { metals = { 'sbt', 'scala' } }
            server_filetype_map = {
                typescript = 'typescript'
            },
            preview = {
                lines_above = 0,
                lines_below = 10,
            },
            scroll_preview = {
                scroll_down = '<C-f>',
                scroll_up = '<C-b>',
            },
            request_timeout = 2000,
            finder = {
                --percentage
                max_height = 0.5,
                force_max_height = false,
                keys = {
                    jump_to = 'p',
                    edit = { 'o', '<CR>' },
                    vsplit = 's',
                    split = 'i',
                    tabe = 't',
                    tabnew = 'r',
                    quit = { 'q', '<ESC>' },
                    close_in_preview = '<ESC>'
                },
            },
            definition = {
                edit = '<C-c>o',
                vsplit = '<C-c>v',
                split = '<C-c>i',
                tabe = '<C-c>t',
                quit = 'q',
            },
            code_action = {
                num_shortcut = true,
                show_server_name = false,
                extend_gitsigns = true,
                keys = {
                    -- string | table type
                    quit = 'q',
                    exec = '<CR>',
                },
            },
            lightbulb = {
                enable = false,
                -- enable = true,
                enable_in_insert = true,
                sign = true,
                sign_priority = 40,
                virtual_text = true,
            },
            diagnostic = {
                on_insert = true,
                on_insert_follow = false,
                insert_winblend = 0,
                show_virt_line = true,
                show_code_action = true,
                show_source = true,
                jump_num_shortcut = true,
                --1 is max
                max_width = 0.7,
                custom_fix = nil,
                custom_msg = nil,
                text_hl_follow = false,
                border_follow = true,
                keys = {
                    exec_action = 'o',
                    quit = 'q',
                    go_action = 'g'
                },
            },
            rename = {
                quit = '<C-c>',
                exec = '<CR>',
                mark = 'x',
                confirm = '<CR>',
                in_select = true,
            },
            outline = {
                -- win_position = 'right',
                win_with = '',
                win_width = 30,
                show_detail = true,
                auto_preview = true,
                auto_refresh = true,
                auto_close = true,
                custom_sort = nil,
                keys = {
                    jump = 'o',
                    expand_collapse = 'u',
                    quit = 'q',
                },
            },
            callhierarchy = {
                show_detail = false,
                keys = {
                    edit = 'e',
                    vsplit = 's',
                    split = 'i',
                    tabe = 't',
                    jump = 'o',
                    quit = 'q',
                    expand_collapse = 'u',
                },
            },
            symbol_in_winbar = {
                enable = false,
                -- enable = true,
                -- -- separator = ' ',
                -- separator = ' ⮁ ',
                -- ignore_patterns = {},
                -- hide_keyword = true,
                -- show_file = true,
                -- folder_level = 6,
                -- respect_root = false,
                -- color_mode = true,
            },
            beacon = {
                enable = true,
                frequency = 7,
            },
            ui = {
                -- This option only works in Neovim 0.9
                title = true,
                -- Border type can be single, double, rounded, solid, shadow.
                border = 'single',
                winblend = 0,
                expand = '',
                collapse = '',
                -- code_action = '💡 ',
                code_action = ' ',
                incoming = ' ',
                outgoing = ' ',
                hover = ' ',
                kind = {},
            },
        })
    end,
    dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
        --Please make sure you install markdown and markdown_inline parser
        { 'nvim-treesitter/nvim-treesitter' }
    }
}

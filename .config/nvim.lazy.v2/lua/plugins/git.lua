return {
    -- git browse and blame
    { 'dinhhuy258/git.nvim' },
    -- show git file modification signs on gutter
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add          = { text = '┃' },
                change       = { text = '┃' }, -- │, ▎
                delete       = { text = '' }, -- , _
                topdelete    = { text = '' }, -- , ‾,
                changedelete = { text = '' }, -- ~, ≈
                untracked    = { text = '┆' },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = '     <author>, <author_time:%d-%m-%Y> • <summary>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil,  -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            -- Options passed to nvim_open_win
            preview_config = {
                border = 'rounded',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1,
                height = 20,
            },
        },
    },
    -- single tabpage interface for easily cycling through git diffs
    -- Configure other misc packages
    -- diffview gives some default keymaps on the merge_tool
    -- :DiffviewOpen to open the mege_tool during merge or rebase to list the conflicted files
    -- The default mapping `g<C-x>` allows you to cycle through the available layouts
    --
    -- You can jump between conflict markers with `]x` and `[x`
    --
    -- Additionally there are mappings for operating directly on the conflict markers:
    --   • `<leader>co`: Choose the OURS version of the conflict.
    --   • `<leader>ct`: Choose the THEIRS version of the conflict.
    --   • `<leader>cb`: Choose the BASE version of the conflict.
    --   • `<leader>ca`: Choose all versions of the conflict (effectively
    --     just deletes the markers, leaving all the content).
    --   • `dx`: Choose none of the versions of the conflict (delete the
    --     conflict region).
    {
        'sindrets/diffview.nvim',
        opts = {
            view = {
                merge_tool = {
                    layout = 'diff3_mixed', -- default layout is diff3_horizontal
                },
            },
        }
    },
    -- visualize and resolve git conflicts
    {
        'akinsho/git-conflict.nvim',
        -- default_mappings  
        -- ours = 'o', -- co choose ours
        -- theirs = 't', -- ct choose theirs
        -- none = '0', -- c0 choose none
        -- both = 'b', -- cb choose both
        -- next = 'n', -- [x move to next conflict
        -- prev = 'n', -- ]x move to prev conflict
        opts = {
            default_mappings = true,     -- disable buffer local mapping created by this plugin
            default_commands = true,     -- disable commands created by this plugin
            disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
            list_opener = 'copen',       -- command or function to open the conflicts list
            highlights = {               -- They must have background color, otherwise the default color will be used
                incoming = 'DiffAdd',
                current = 'DiffText',
            }
        }
    }
}


return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-file-browser.nvim', -- kind of a replacement for :Lex
        'nvim-telescope/telescope-live-grep-args.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
    },
    config = function()
        require('telescope').setup {
            defaults = {
                prompt_prefix = '❯ ',
                path_display = { 'smart' },
                -- Default configuration for telescope goes here:
                -- config_key = value,
                mappings = {
                    i = {
                        -- map actions.which_key to <C-h> (default: <C-/>)
                        -- actions.which_key shows the mappings for your picker,
                        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                        ['<C-h>'] = 'which_key',
                        -- ['<C-n>'] = actions.cycle_history_next,
                        -- ['<C-p>'] = actions.cycle_history_prev,
                        --
                        -- ['<C-j>'] = actions.move_selection_next,
                        -- ['<C-k>'] = actions.move_selection_previous,
                        --
                        -- ['<C-c>'] = actions.close,
                        --
                        -- ['<Down>'] = actions.move_selection_next,
                        -- ['<Up>'] = actions.move_selection_previous,
                        --
                        -- ['<CR>'] = actions.select_default,
                        -- ['<C-x>'] = actions.select_horizontal,
                        -- ['<C-v>'] = actions.select_vertical,
                        -- ['<C-t>'] = actions.select_tab,
                        --
                        -- ['<C-u>'] = actions.preview_scrolling_up,
                        -- ['<C-d>'] = actions.preview_scrolling_down,
                        --
                        -- ['<PageUp>'] = actions.results_scrolling_up,
                        -- ['<PageDown>'] = actions.results_scrolling_down,
                        --
                        -- ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                        -- ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                        -- ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                        -- ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                        -- ['<C-l>'] = actions.complete_tag,
                        -- ['<C-_>'] = actions.which_key, -- keys from pressing <C-/>
                    },
                    n = {
                        -- ['<esc>'] = actions.close,
                        -- ['<CR>'] = actions.select_default,
                        -- ['<C-x>'] = actions.select_horizontal,
                        -- ['<C-v>'] = actions.select_vertical,
                        -- ['<C-t>'] = actions.select_tab,
                        --
                        -- ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                        -- ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                        -- ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                        -- ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                        --
                        -- ['j'] = actions.move_selection_next,
                        -- ['k'] = actions.move_selection_previous,
                        -- ['H'] = actions.move_to_top,
                        -- ['M'] = actions.move_to_middle,
                        -- ['L'] = actions.move_to_bottom,
                        --
                        -- ['<Down>'] = actions.move_selection_next,
                        -- ['<Up>'] = actions.move_selection_previous,
                        -- ['gg'] = actions.move_to_top,
                        -- ['G'] = actions.move_to_bottom,
                        --
                        -- ['<C-u>'] = actions.preview_scrolling_up,
                        -- ['<C-d>'] = actions.preview_scrolling_down,
                        --
                        -- ['<PageUp>'] = actions.results_scrolling_up,
                        -- ['<PageDown>'] = actions.results_scrolling_down,
                        --
                        -- ['?'] = actions.which_key,
                    },
                },
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
                -- find_files = {
                --     theme = 'dropdown',
                -- }
                commands = {
                    theme = 'dropdown',
                    layout_config = {
                        height = 0.9,
                        width = 0.8,
                    }
                }
            },
            extensions = {
                -- Your extension configuration goes here:
                -- extension_name = {
                --   extension_config_key = value,
                -- }
                -- please take a look at the readme of the extension you want to configure
                file_browser = {
                    theme = 'dropdown',
                    hijack_netrw = false, -- to disable netrw and use telescopes file browser change to true
                    mappings = {
                        i = {
                            -- your custom insert mode mappings
                            ['<C-w>'] = function() vim.cmd('normal vbd') end,
                        },
                        n = {
                            -- your custom normal mode mappings
                            ['N'] = require 'telescope'.extensions.file_browser.actions.create,
                            ['h'] = require 'telescope'.extensions.file_browser.actions.goto_parent_dir,
                            ['/'] = function()
                                vim.cmd('startinsert')
                            end
                        },
                    },
                },
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = 'smart_case',       -- or 'ignore_case' or 'respect_case'
                    -- the default case_mode is 'smart_case'
                },
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = {
                        -- extend mappings
                        i = {
                            ['<C-k>'] = require('telescope-live-grep-args.actions').quote_prompt(),
                            ['<C-i>'] = require('telescope-live-grep-args.actions').quote_prompt({ postfix = ' --iglob ' }),
                        },
                    },
                    -- ... also accepts theme settings, for example:
                    -- theme = 'dropdown', -- use dropdown theme
                    -- theme = { }, -- use own theme spec
                    -- layout_config = { mirror=true }, -- mirror preview pane
                }
            },
        }
        -- Enable telescope live_grep_args
        require('telescope').load_extension('live_grep_args')
        -- Enable telescope fzf native, if installed
        require('telescope').load_extension('fzf')
    end,
}

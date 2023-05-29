return {
    -- nvim-treesitter-textobjects
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        depedencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    -- nvim-treesitter-playground
    { 'nvim-treesitter/playground' },
    -- nvim-treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update({ with_sync = true }))
        end,
        opts = {
            -- [[ Configure nvim-treesitter ]]
            -- See `:help nvim-treesitter`
            ensure_installed = {
                'tsx',
                'toml',
                'fish',
                'php',
                'json',
                'yaml',
                'swift',
                'css',
                'html',
                'lua',
                'java',
                'javascript',
                'jsdoc',
                'json',
                'json5',
                'markdown',
                'markdown_inline',
                'typescript',
            },
            highlight = {
                enable = true,
                disable = {},
            },
            indent = {
                enable = true,
                disable = {},
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<s-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-s>',
                    node_decremental = '<c-backspace>',
                },
            },
            -- textobjects = {
            --   select = {
            --     enable = true,
            --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim                                            -
            --     keymaps = {
            --       -- You can use the capture groups defined in textobjects.scm
            --       ['aa'] = '@parameter.outer',
            --       ['ia'] = '@parameter.inner',
            --       ['af'] = '@function.outer',
            --       ['if'] = '@function.inner',
            --       ['ac'] = '@class.outer',
            --       ['ic'] = '@class.inner',
            --     },
            --   },
            --   move = {
            --     enable = true,
            --     set_jumps = true, -- whether to set jumps in the jumplist                                                                     •
            --     goto_next_start = {
            --       [']m'] = '@function.outer',
            --       [']]'] = '@class.outer',
            --     },
            --     goto_next_end = {
            --       [']M'] = '@function.outer',
            --       [']['] = '@class.outer',
            --     },
            --     goto_previous_start = {
            --       ['[m'] = '@function.outer',
            --       ['[['] = '@class.outer',
            --     },
            --     goto_previous_end = {
            --       ['[M'] = '@function.outer',
            --       autotag = {
            --         enable = true,
            --       },
            --     }
            --   },
            --   swap = {
            --     enable = true,
            --     swap_next = {
            --       ['<leader>a'] = '@parameter.inner',
            --     },
            --     swap_previous = {
            --       ['<leader>A'] = '@parameter.inner',
            --     },
            --   },
            -- }
        },
        config = function()
            local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
            parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

            -- setup required for treesitter playground
            local nvim_treesitter_config = require('nvim-treesitter.configs')
            nvim_treesitter_config.setup {
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?',
                    },
                    query_linter = {
                        enable = true,
                        use_virtual_text = true,
                        lint_events = { 'BufWrite', 'CursorHold' },
                    },
                }
            }
        end
    },
}

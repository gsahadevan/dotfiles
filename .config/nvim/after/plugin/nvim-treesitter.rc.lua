local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
    print('nvim-treesitter is not installed')
    return
end

-- [[ Configure nvim-treesitter ]]
-- See `:help nvim-treesitter`
treesitter.setup {
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
        'javascript',
        'typescript'
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
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

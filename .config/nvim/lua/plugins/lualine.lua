-- Color table for highlights
-- stylua: ignore
local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#ec5f67',
    white    = '#ffffff',
    black    = '#000000',
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local diagnostics = {
    'diagnostics',
    -- Table of diagnostic sources, available sources are:
    --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
    -- or a function that returns a table as such:
    --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
    sources = { 'nvim_diagnostic' },
    sections = { 'error', 'warn' }, -- Displays diagnostics for the defined severity types, also has info and hint
    -- diagnostics_color = {
    --     -- Same values as the general color option can be used here.
    --     error = 'DiagnosticError',           -- Changes diagnostics' error color.
    --     warn  = 'DiagnosticWarn',            -- Changes diagnostics' warn color.
    --     info  = 'DiagnosticInfo',            -- Changes diagnostics' info color.
    --     hint  = 'DiagnosticHint',            -- Changes diagnostics' hint color.
    -- },
    -- symbols = { error = ' ', warn = ' ' }, -- Also has info and hint
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
    },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    colored = true,
    -- colored = false,          -- Displays diagnostics status in color if set to true.
    update_in_insert = false, -- Update diagnostics in insert mode.
    always_visible = false,   -- Show diagnostics even if there are none.,
    cond = conditions.hide_in_width,
}

local diff = {
    'diff',
    -- colored = false, -- Displays a colored diff status if set to true
    -- diff_color = {
    --     -- Same color values as the general color option can be used here.
    --     added    = 'DiffAdd',    -- Changes the diff's added color
    --     modified = 'DiffChange', -- Changes the diff's modified color
    --     removed  = 'DiffDelete', -- Changes the diff's removed color you
    -- },
    colored = true,
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    symbols = { added = ' ', modified = ' ', removed = ' ' }, -- Changes the symbols used by the diff.
    source = nil,                                                -- A function that works as a data source for diff.
    -- It must return a table as such:
    --   { added = add_count, modified = modified_count, removed = removed_count }
    -- or nil on failure. count <= 0 won't be displayed.

    -- comments from me; old code
    -- symbols = { added = '+', modified = '~', removed = '-' }, -- Changes the symbols used by the diff.
    -- symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
    -- cond = function()
    --   return vim.fn.winwidth(0) > 80
    -- end
    cond = conditions.hide_in_width,
}

local fileformat = {
    'fileformat',
    symbols = {
        -- unix = '', -- e712
        -- dos = '', -- e70f
        -- mac = '', -- e711
        unix = 'LF',  -- e712
        dos = 'CRLF', -- e70f
        mac = 'CR',   -- e711
    },
}

local filename = {
    'filename',
    file_status = true,     -- Displays file status (readonly status, modified status)
    newfile_status = false, -- Display new file status (new file means no write after created)
    path = 0,               -- 0: Just the filename
    -- 1: Relative path
    -- 2: Absolute path
    -- 3: Absolute path, with tilde as the home directory
    -- 4: Filename and parent dir, with tilde as the home directory

    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
    -- for other components. (terrible name, any suggestions?)
    symbols = {
        modified = '[+]',      -- Text to show when the file is modified.
        readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]',     -- Text to show for newly created file before first write
    }
}

local filetype = {
    'filetype',
    colored = true,            -- Displays filetype icon in color if set to true
    icon_only = false,         -- Display only an icon for filetype
    icon = { align = 'left' }, -- Display filetype icon on the right hand side
    -- icon =    {'X', align='right'}
    -- Icon string ^ in table is ignored in filetype component
}

-- local mode = {
--     'mode',
--     icons_enabled = true, -- Enables the display of icons alongside the component.
--     -- Defines the icon to be displayed in front of the component.
--     -- Can be string|table
--     -- As table it must contain the icon as first entry and can use
--     -- color option to custom color the icon. Example:
--     -- {'branch', icon = ''} / {'branch', icon = {'', color={fg='green'}}}
--
--     -- icon position can also be set to the right side from table. Example:
--     -- {'branch', icon = {'', align='right', color={fg='green'}}}
--     icon = nil,
--
--     separator = nil, -- Determines what separator to use for the component.
--     -- Note:
--     --  When a string is provided it's treated as component_separator.
--     --  When a table is provided it's treated as section_separator.
--     --  Passing an empty string disables the separator.
--     --
--     -- These options can be used to set colored separators
--     -- around a component.
--     --
--     -- The options need to be set as such:
--     --   separator = { left = '', right = ''}
--     --
--     -- Where left will be placed on left side of component,
--     -- and right will be placed on its right.
--     --
--
--     cond = nil,         -- Condition function, the component is loaded when the function returns `true`.
--
--     draw_empty = false, -- Whether to draw component even if it's empty.
--     -- Might be useful if you want just the separator.
--
--     -- Defines a custom color for the component:
--     --
--     -- 'highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' } | function
--     -- Note:
--     --  '|' is synonymous with 'or', meaning a different acceptable format for that placeholder.
--     -- color function has to return one of other color types ('highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' })
--     -- color functions can be used to have different colors based on state as shown below.
--     --
--     -- Examples:
--     --   color = { fg = '#ffaa88', bg = 'grey', gui='italic,bold' },
--     --   color = { fg = 204 }   -- When fg/bg are omitted, they default to the your theme's fg/bg.
--     --   color = 'WarningMsg'   -- Highlight groups can also be used.
--     --   color = function(section)
--     --      return { fg = vim.bo.modified and '#aa3355' or '#33aa88' }
--     --   end,
--     color = nil, -- The default is your theme's color for that section and mode.
--
--     -- Specify what type a component is, if omitted, lualine will guess it for you.
--     --
--     -- Available types are:
--     --   [format: type_name(example)], mod(branch/filename),
--     --   stl(%f/%m), var(g:coc_status/bo:modifiable),
--     --   lua_expr(lua expressions), vim_fun(viml function name)
--     --
--     -- Note:
--     -- lua_expr is short for lua-expression and vim_fun is short for vim-function.
--     type = nil,
--
--     padding = 1, -- Adds padding to the left and right of components.
--     -- Padding can be specified to left or right independently, e.g.:
--     --   padding = { left = left_padding, right = right_padding }
--
--     fmt = nil, -- Format function, formats the component's output.
--     -- This function receives two arguments:
--     -- - string that is going to be displayed and
--     --   that can be changed, enhanced and etc.
--     -- - context object with information you might
--     --   need. E.g. tabnr if used with tabs.
--     on_click = nil, -- takes a function that is called when component is clicked with mouse.
--     -- the function receives several arguments
--     -- - number of clicks in case of multiple clicks
--     -- - mouse button used (l(left)/r(right)/m(middle)/...)
--     -- - modifiers pressed (s(shift)/c(ctrl)/a(alt)/m(meta)...)
-- }

local lbar = {
    function()
        return '▊'
    end,
    padding = { left = 0, right = 1 }
}

local rbar = {
    function()
        return '▊'
    end,
    padding = { left = 0, right = 1 }
}

local lsp = {
    function()
        local msg = 'none'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = ' lsp:',
    color = { fg = colors.cyan },
}

local branch = {
    'branch',
    color = { fg = colors.cyan },
}

local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
local scrollbar = {
    function()
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #sbar) + 1
        if sbar[i] then return sbar[i] end
    end,
    color = { fg = colors.yellow },
    padding = { left = 0, right = 0 }
}

-- list of themes are available here
-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
-- list of config options are available here
-- https://github.com/nvim-lualine/lualine.nvim/tree/master/examples
return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = 'horizon', -- lualine theme
                -- component_separators = { left = '', right = '' },
                -- section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },

                disabled_filetypes = {
                    -- Filetypes to disable lualine for.
                    'packer',
                    'NvimTree',
                    -- 'neo-tree',
                    statusline = {}, -- only ignores the ft for statusline.
                    winbar = {},     -- only ignores the ft for winbar.
                },

                ignore_focus = {}, -- If current filetype is in this list it'll
                -- always be drawn as inactive statusline
                -- and the last window will be drawn as active statusline.
                -- for example if you don't want statusline of
                -- your file tree / sidebar window to have active
                -- statusline you can add their filetypes here.

                always_divide_middle = true, -- When set to true, left sections i.e. 'a','b' and 'c'
                -- can't take over the entire statusline even
                -- if neither of 'x', 'y' or 'z' are present.

                globalstatus = true, -- enable global statusline (have a single statusline
                -- at bottom of neovim instead of one for  every window).
                -- This feature is only available in neovim 0.7 and higher.

                refresh = {
                    -- sets how often lualine should refresh it's contents (in ms)
                    statusline = 1000, -- The refresh option sets minimum time that lualine tries
                    tabline = 1000,    -- to maintain between refresh. It's not guarantied if situation
                    winbar = 1000      -- arises that lualine needs to refresh itself before this time
                    -- it'll do it.

                    -- Also you can force lualine's refresh by calling refresh function
                    -- like require('lualine').refresh()
                }
            },
            sections = {
                lualine_a = { lbar },
                lualine_b = {},
                lualine_c = { branch, diff },
                lualine_x = { diagnostics, lsp, 'location', 'encoding', fileformat, filetype, 'progress' },
                lualine_y = { scrollbar },
                lualine_z = { rbar },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { filename },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        })
    end
}

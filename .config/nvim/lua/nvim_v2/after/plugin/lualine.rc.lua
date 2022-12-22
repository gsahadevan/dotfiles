local status, lualine = pcall(require, 'lualine')
if (not status) then return end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    'diagnostics',
    -- sources = { 'nvim_diagnostics' },
    --:wq
    --sections = { 'error', 'warn', 'info', 'hint' },
    -- symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
    -- symbols = { error = " ", warn = " ", hint = " ", info = " " },
    sections = { 'error', 'warn' },
    symbols = { error = " ", warn = " " },
    update_in_insert = false,
    always_visible = true,
}

local filename = {
    'filename',
    file_status = true, -- displays file status (readonly or modified)
    path = 1, -- 0 = only filename | 1 = relative path | 2 = absolute path
}

local location = { 'location' }

local diff = {
    'diff',
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
}

-- local spaces = function()
--     return 'spaces: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
-- end

-- local encoding = { 'encoding' }
local filetype = { 'filetype' }

-- local progress_minimap = function()
--     local current_line = vim.fn.line('.')
--     local total_lines = vim.fn.line('$')
--     local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
--     local line_ratio = current_line / total_lines
--     local index = math.ceil(line_ratio * #chars)
--     return chars[index]
-- end

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        -- component_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = ''},
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = {
            'packer', 'NvimTree',
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    -- override default param
    -- sections = {
    -- lualine_a = {'mode'},
    -- lualine_b = {'branch', 'diff', 'diagnostics'},
    -- lualine_c = {'filename'},
    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
    -- lualine_y = {'progress'},
    -- lualine_z = {'location'}
    -- },
    -- sections = {
    --     lualine_a = { 'mode' },
    --     lualine_b = { 'branch', diff },
    --     lualine_c = { filename },
    --     lualine_x = { diagnostics, spaces, encoding, filetype },
    --     lualine_y = { location },
    --     lualine_z = { progress_minimap }
    -- },
    -- sections = {
    --     lualine_a = { 'mode' },
    --     lualine_b = { 'branch', diff },
    --     lualine_c = { filename },
    --     lualine_x = { diagnostics, filetype },
    --     lualine_y = {},
    --     lualine_z = { location },
    -- },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { filename },
        lualine_x = {},
        lualine_y = { location },
        lualine_z = {}
    },
    tabline = {},
    winbar = {
        lualine_c = { filename }
    },
    inactive_winbar = {
        lualine_c = { filename }
    },
    extensions = {}
}

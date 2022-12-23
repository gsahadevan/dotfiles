local status, lualine = pcall(require, 'lualine')
if not status then
    print('lualine is not installed')
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    'diagnostics',
    -- sources = { 'nvim_diagnostics' },
    -- sections = { 'error', 'warn', 'info', 'hint' },
    -- symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
    -- symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
    sections = { 'error', 'warn' },
    symbols = { error = ' ', warn = ' ' },
    update_in_insert = true,
    always_visible = true,
}

local filename = {
    'filename',
    file_status = true, -- displays file status (readonly or modified)
    path = 1, -- 0 = only filename | 1 = relative path | 2 = absolute path
}

local diff = {
    'diff',
    symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
    cond = hide_in_width,
}

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
        globalstatus = true, -- if false; lualine will not be under nvim-tree
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', diff },
        lualine_c = {},
        lualine_x = { diagnostics },
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { filename },
        lualine_x = {},
        lualine_y = { 'location' },
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

local status, cokeline = pcall(require, 'cokeline')
if not status then
    print('cokeline is not installed')
    return
end

local get_hex = require('cokeline/utils').get_hex

cokeline.setup({
    sidebar = {
        filetype = 'NvimTree',
        components = {
            {
                text = '  Explorer',
                fg = vim.g.terminal_color_2,
                bg = get_hex('NvimTreeNormal', 'bg'),
                style = 'bold',
            },
        }
    },
})

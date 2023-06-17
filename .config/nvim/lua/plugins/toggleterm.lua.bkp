-- A neovim plugin to persist and toggle multiple terminals during an editing session
return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        require('toggleterm').setup({
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminlas = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            -- direction = 'float',
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = 'curved',
                winblend = 10,
                width = function()
                    return math.ceil(vim.o.columns * 0.85)
                end,
                height = function()
                    return math.ceil(vim.o.lines * 0.85)
                end,
                highlights = {
                    border = 'FloatBorder',
                    background = 'NormalFloat',
                },
            },
        })
    end
}

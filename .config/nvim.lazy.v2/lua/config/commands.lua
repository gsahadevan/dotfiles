-- ╭───────────────────────────────────╮
-- │ Custom commands                   │
-- ╰───────────────────────────────────╯

-- Function to close all other buffers except the current one, with a warning for unsaved changes
local function close_other_buffers()
    local unsaved_buffers = {}
    local current_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
            local modified = vim.api.nvim_get_option_value('modified', { buf = buf })
            if modified then
                table.insert(unsaved_buffers, buf)
            else
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end
    if #unsaved_buffers > 0 then
        local buffer_names = {}
        for _, buf in ipairs(unsaved_buffers) do
            table.insert(buffer_names, vim.api.nvim_buf_get_name(buf))
        end
        local message = 'Unsaved changes in buffers:\n' .. table.concat(buffer_names, '\n')
        print(message)
    end
end

-- Command to close all other buffers except the current one
vim.api.nvim_create_user_command('CustomCloseOtherBuffers', close_other_buffers,
    { desc = 'Close all other buffers except the current one, warn about unsaved changes' })

-- Function to close all buffers with a warning for unsaved changes
local function close_all_buffers()
    local unsaved_buffers = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            local modified = vim.api.nvim_get_option_value('modified', { buf = buf })
            if modified then
                table.insert(unsaved_buffers, buf)
            else
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end
    if #unsaved_buffers > 0 then
        local buffer_names = {}
        for _, buf in ipairs(unsaved_buffers) do
            table.insert(buffer_names, vim.api.nvim_buf_get_name(buf))
        end
        local message = 'Unsaved changes in buffers:\n' .. table.concat(buffer_names, '\n')
        print(message)
    end
end

-- Command to close all buffers
vim.api.nvim_create_user_command('CustomCloseAllBuffers', close_all_buffers,
    { desc = 'Close all buffers, warn about unsaved changes' })

-- Function to change the colorscheme
local function change_colorscheme(themes)
    vim.api.nvim_command('colorscheme ' .. themes.args)
    require('lualine').setup { options = { theme = themes.args } }
    require('lualine').refresh()
end

-- Function to get available colorschemes for completion
local function colorscheme_completion(current_input)
    local themes = {}
    for _, name in ipairs(vim.fn.getcompletion(current_input, 'color')) do
        table.insert(themes, name)
    end
    return themes
end

-- Command to change the colorscheme
vim.api.nvim_create_user_command('CustomChangeColorscheme', change_colorscheme,
    { nargs = 1, complete = colorscheme_completion, desc = 'Change the colorscheme' })

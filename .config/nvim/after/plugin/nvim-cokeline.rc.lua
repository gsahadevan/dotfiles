local status, cokeline = pcall(require, 'cokeline')
if not status then
    print('cokeline is not installed')
    return
end

local get_hex          = require('cokeline/utils').get_hex
local color_comment_fg = get_hex('Comment', 'fg')
local color_warning_fg = get_hex('DiagnosticWarn', 'fg')
local color_error_fg   = get_hex('DiagnosticError', 'fg')
local color_focus_fg   = '#ccccff'
local color_focus_bg   = '#5f5eaf'
local color_default_bg = 'none'

cokeline.setup({
    default_hl = {
        -- overriding default | no background color
        fg = function(buffer)
            local color = color_comment_fg

            -- If the buffer is focussed change the color - more bright
            if buffer.is_focused then
                color = color_focus_fg
            end

            -- Warnings take the higher precedence
            if buffer.diagnostics.warnings > 0 then
                color = color_warning_fg
            end

            -- Errors take the highest precedence
            if buffer.diagnostics.errors > 0 then
                color = color_error_fg
            end
            return color
        end,
        -- default: `Normal`'s foreground color for focused buffers,
        -- `ColorColumn`'s background color for unfocused ones.
        -- default: `Normal`'s foreground color.
        bg = function(buffer)
            return buffer.is_focused and color_focus_bg or color_default_bg
        end,
        style = 'none',
    },
    -- A list of components to be rendered for each buffer. Check out the section
    -- below explaining what this value can be set to.
    -- default: see `/lua/cokeline/defaults.lua`
    components = {
        {
            text = function(buffer)
                return ' ' .. buffer.devicon.icon
            end,
            fg = function(buffer)
                return buffer.devicon.color
            end,
        },
        {
            text = function(buffer)
                return buffer.unique_prefix .. ' '
            end,
            fg = color_comment_fg,
            style = 'italic',
        },
        {
            text = function(buffer)
                return buffer.filename .. ' '
            end,
        },
        -- Modified the default
        -- The indicator is either modified or close
        {
            text = function(buffer)
                return buffer.is_modified and '' or ''
            end,
        },
        {
            text = ' '
        }
    },
    -- Left sidebar to integrate nicely with file explorer plugins.
    -- This is a table containing a `filetype` key and a list of `components` to
    -- be rendered in the sidebar.
    -- The last component will be automatically space padded if necessary
    -- to ensure the sidebar and the window below it have the same width.
    sidebar = {
        filetype = 'NvimTree',
        components = {
            {
                text = '  EXPLORER',
                fg = vim.g.terminal_color_2,
                bg = get_hex('NvimTreeNormal', 'bg'),
                style = 'bold',
            },
        }
    },
})

vim.api.nvim_set_keymap('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
vim.api.nvim_set_keymap('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>p', '<Plug>(cokeline-switch-prev)', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>n', '<Plug>(cokeline-switch-next)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':Bdelete<CR>', { noremap = true, silent = true })

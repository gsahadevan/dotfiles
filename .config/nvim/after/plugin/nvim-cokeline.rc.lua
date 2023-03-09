local status, cokeline = pcall(require, 'cokeline')
if not status then
    print('cokeline is not installed')
    return
end

local color_warning_fg  = '#e2c08d'
local color_error_fg    = '#f88070'
local color_comment_fg  = '#7f8083'
local color_focus_fg    = '#dcdcdc'
local color_focus_bg    = '#21252b'
local color_default_bg  = '#282c34'
local color_nvimtree_fg = '#abb2bf'
local color_nvimtree_bg = '#191b1f'
local space             = { text = ' ' }

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
        bg = function(buffer)
            return buffer.is_focused and color_focus_bg or color_default_bg
        end,
        style = 'none',
    },
    -- A list of components to be rendered for each buffer. Check out the section
    -- below explaining what this value can be set to.
    -- default: see `/lua/cokeline/defaults.lua`
    components = {
        space,
        {
            text = function(buffer)
                return buffer.devicon.icon
            end,
            fg = function(buffer)
                return buffer.devicon.color
            end,
        },
        {
            text = function(buffer)
                return buffer.unique_prefix
            end,
            fg = color_comment_fg,
            style = 'italic',
        },
        space,
        {
            text = function(buffer)
                return buffer.filename
            end,
            style = function(buffer)
                return buffer.is_focused and 'underline' or 'none'
            end,
        },
        -- Modified the default
        -- The indicator is either modified or close
        {
            text = function(buffer)
                return buffer.is_modified and ' ' .. '' or ' ' .. ''
            end,
        },
        space,
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
                fg = color_nvimtree_fg,
                bg = color_nvimtree_bg,
                style = 'underline',
            },
        }
    },
})

vim.api.nvim_set_keymap('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
vim.api.nvim_set_keymap('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>p', '<Plug>(cokeline-switch-prev)', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>n', '<Plug>(cokeline-switch-next)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':Bdelete<CR>', { noremap = true, silent = true })

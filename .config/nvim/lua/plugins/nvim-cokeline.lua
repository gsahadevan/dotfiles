local colors = {
    warning_fg  = '#e2c08d',
    error_fg    = '#f88070',
    comment_fg  = '#7f8083',
    focus_fg    = '#dcdcdc',
    focus_bg    = '#21252b',
    default_bg  = '#282c34',
    nvimtree_fg = '#abb2bf',
    nvimtree_bg = '#191b1f',
}

local space  = { text = ' ' }

return {
    'noib3/nvim-cokeline',
    dependencies = 'nvim-tree/nvim-web-devicons', -- buffer line
    config = function()
        require('cokeline').setup({
            default_hl = {
                -- overriding default | no background color
                fg = function(buffer)
                    local color = colors.comment_fg

                    -- If the buffer is focussed change the color - more bright
                    if buffer.is_focused then
                        color = colors.focus_fg
                    end

                    -- Warnings take the higher precedence
                    if buffer.diagnostics.warnings > 0 then
                        color = colors.warning_fg
                    end

                    -- Errors take the highest precedence
                    if buffer.diagnostics.errors > 0 then
                        color = colors.error_fg
                    end
                    return color
                end,
                bg = function(buffer)
                    return buffer.is_focused and colors.focus_bg or colors.default_bg
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
                    fg = colors.comment_fg,
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
                filetype = 'neo-tree',
                components = {
                    {
                        text = '  EXPLORER',
                        fg = colors.nvimtree_fg,
                        bg = colors.nvimtree_bg,
                        style = 'none', -- Also can be bold, italic, underline
                    },
                }
            },
        })
    end
}

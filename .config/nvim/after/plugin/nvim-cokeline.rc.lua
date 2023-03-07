-- local status, cokeline = pcall(require, 'cokeline')
-- if not status then
--     print('cokeline is not installed')
--     return
-- end
--
-- local get_hex = require('cokeline/utils').get_hex
--
-- cokeline.setup({
--     default_hl = {
--         -- overriding default | no background color
--         -- fg = function(buffer)
--         --     return buffer.is_focused and get_hex('ColorColumn', 'fg') or get_hex('Comment', 'fg')
--         -- end,
--         -- bg = function(buffer)
--         --     return buffer.is_focused and get_hex('Normal', 'fg')
--         --         or get_hex('ColorColumn', 'bg')
--         -- end,
--         fg = function(buffer)
--             local color = get_hex('Comment', 'fg')
--
--             -- If the buffer is focussed change the color - more bright
--             if buffer.is_focused then
--                 color = get_hex('ColorColumn', 'fg')
--             end
--
--             -- Warnings take the higher precedence
--             if buffer.diagnostics.warnings > 0 then
--                 color = get_hex('DiagnosticWarn', 'fg')
--             end
--
--             -- Errors take the highest precedence
--             if buffer.diagnostics.errors > 0 then
--                 color = get_hex('DiagnosticError', 'fg')
--             end
--             return color
--         end,
--         bg = 'none',
--         style = 'none',
--     },
--     components = {
--         {
--             text = function(buffer)
--                 return ' ' .. buffer.devicon.icon
--             end,
--             fg = function(buffer)
--                 return buffer.devicon.color
--             end,
--         },
--         {
--             text = function(buffer)
--                 return buffer.unique_prefix
--             end,
--             fg = get_hex('Comment', 'fg'),
--             style = 'italic',
--         },
--         {
--             text = function(buffer)
--                 return buffer.filename .. ' '
--             end,
--         },
--         -- {
--         --     text = function(buffer)
--         --         -- return buffer.is_modified and '●' .. ' ' or ''
--         --         return buffer.is_modified and '[+]' .. ' ' or ''
--         --     end,
--         -- },
--         -- {
--         --     text = '',
--         --     delete_buffer_on_left_click = true,
--         -- },
--         -- Modified the default
--         -- The indicator is either modified or close
--         {
--             text = function(buffer)
--                 return buffer.is_modified and '●' or ''
--             end,
--         },
--         {
--             text = ' ',
--         },
--     },
--     -- components = {
--     --     -- components.space,
--     --     -- components.separator,
--     --     -- components.space,
--     --     -- components.devicon,
--     --     -- components.space,
--     --     -- components.index,
--     --     -- components.unique_prefix,
--     --     -- components.filename,
--     --     -- components.diagnostics,
--     --     -- components.two_spaces,
--     --     -- components.close_or_unsaved,
--     --     -- components.space,
--     -- },
--     sidebar = {
--         filetype = 'NvimTree',
--         components = {
--             {
--                 text = '  EXPLORER',
--                 fg = vim.g.terminal_color_2,
--                 bg = get_hex('NvimTreeNormal', 'bg'),
--                 -- style = 'bold',
--             },
--         }
--     },
-- })
--
-- local map = vim.api.nvim_set_keymap
--
-- map('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
-- map('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
-- map('n', '<Leader>p', '<Plug>(cokeline-switch-prev)', { silent = true })
-- map('n', '<Leader>n', '<Plug>(cokeline-switch-next)', { silent = true })
-- map('n', '<leader>w', ':Bdelete<CR>', { noremap = true, silent = true })


local is_picking_focus = require('cokeline/mappings').is_picking_focus
local is_picking_close = require('cokeline/mappings').is_picking_close
local get_hex = require('cokeline/utils').get_hex

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_4
local space = { text = ' ' }
local dark = get_hex('Normal', 'bg')
local text = get_hex('Comment', 'fg')
-- local grey = get_hex('ColorColumn', 'bg')
-- local light = get_hex('Comment', 'fg')
-- local high = '#a6d120'
-- local high = '#5f5eaf'
local default_fg = get_hex('ColorColumn', 'fg')
local default_bg = get_hex('ColorColumn', 'bg')
local focus_bg = '#5f5eaf'
local focus_fg = '#ffffff'

require('cokeline').setup(
    {
        default_hl = {
            fg = function(buffer)
                return buffer.is_focused and dark or text
            end,
            bg = function(buffer)
                return buffer.is_focused and focus_bg or default_bg
            end
        },
        components = {
            {
                text = function(buffer)
                    if buffer.index ~= 1 then
                        return ' '
                    end
                    return ''
                end,
                bg = function(buffer)
                    return buffer.is_focused and focus_bg or default_bg
                end,
                fg = default_fg
            },
            space,
            {
                text = function(buffer)
                    if is_picking_focus() or is_picking_close() then
                        return buffer.pick_letter .. ' '
                    end

                    return buffer.devicon.icon
                end,
                fg = function(buffer)
                    if is_picking_focus() then
                        return yellow
                    end
                    if is_picking_close() then
                        return red
                    end

                    if buffer.is_focused then
                        return dark
                    else
                        return light
                    end
                end,
                style = function(_)
                    return (is_picking_focus() or is_picking_close()) and 'italic,bold' or nil
                end
            },
            {
                text = function(buffer)
                    return buffer.unique_prefix .. buffer.filename .. '⠀'
                end,
                style = function(buffer)
                    return buffer.is_focused and 'bold' or nil
                end,
                fg = function(buffer)
                    return buffer.is_focused and default_fg or default_fg
                end
            },
            {
                text = ' ',
                fg = function(buffer)
                    return buffer.is_focused and focus_bg or default_fg
                end,
                bg = default_bg
            }
        }
    }
)

local is_picking_focus = require('cokeline/mappings').is_picking_focus
local is_picking_close = require('cokeline/mappings').is_picking_close
local get_hex = require('cokeline/utils').get_hex

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_4
local space = { text = ' ' }
local dark = get_hex('Normal', 'bg')
local text = get_hex('Comment', 'fg')
local grey = get_hex('ColorColumn', 'bg')
local light = get_hex('Comment', 'fg')
local high = '#a6d120'

require('cokeline').setup(
    {
        default_hl = {
            fg = function(buffer)
                if buffer.is_focused then
                    return dark
                end
                return text
            end,
            bg = function(buffer)
                if buffer.is_focused then
                    return high
                end
                return grey
            end
        },
        components = {
            {
                text = function(buffer)
                    if buffer.index ~= 1 then
                        return ''
                    end
                    return ''
                end,
                bg = function(buffer)
                    if buffer.is_focused then
                        return high
                    end
                    return grey
                end,
                fg = dark
            },
            space,
            {
                text = function(buffer)
                    if is_picking_focus() or is_picking_close() then
                        return buffer.pick_letter .. ' '
                    end

                    return buffer.devicon.icon
                end,
                fg = function(buffer)
                    if is_picking_focus() then
                        return yellow
                    end
                    if is_picking_close() then
                        return red
                    end

                    if buffer.is_focused then
                        return dark
                    else
                        return light
                    end
                end,
                style = function(_)
                    return (is_picking_focus() or is_picking_close()) and 'italic,bold' or nil
                end
            },
            {
                text = function(buffer)
                    return buffer.unique_prefix .. buffer.filename .. '⠀'
                end,
                style = function(buffer)
                    return buffer.is_focused and 'bold' or nil
                end
            },
            {
                text = '',
                fg = function(buffer)
                    if buffer.is_focused then
                        return high
                    end
                    return grey
                end,
                bg = dark
            }
        }
    }
)

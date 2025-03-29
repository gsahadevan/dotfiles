return {
    'numToStr/Comment.nvim',
    keys = {
        { 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
        { 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
    },
    opts = function()
        local commentstring_avail, commentstring = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
        return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
    end,
    config = function()
        require('Comment').setup {
            padding = true, -- Add a space b/w comment and the line
            sticky = true,  -- Whether the cursor should stay at its position
            ignore = nil,   -- Lines to be ignored while (un)comment
            -- LHS of toggle mappings in NORMAL mode
            toggler = {
                line = 'gcc',  -- Line-comment toggle keymap
                block = 'gbc', -- Block-comment toggle keymap
            },
            -- LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                line = 'gc',  -- Line-comment keymap
                block = 'gb', -- Block-comment keymap
            },
            -- LHS of extra mappings
            extra = {
                above = 'gcO', -- Add comment on the line above
                below = 'gco', -- Add comment on the line below
                eol = 'gcA',   -- Add comment at the end of line
            },
            -- Enable keybindings
            -- NOTE: If given `false` then the plugin won't create any mappings
            mappings = {
                basic = true, -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                extra = true, -- Extra mapping; `gco`, `gcO`, `gcA`
            },
            -- Function to call before (un)comment
            -- pre_hook = nil,
            pre_hook = function(ctx)
                -- Only calculate commentstring for tsx filetypes
                if vim.bo.filetype == 'typescriptreact' then
                    local U = require('Comment.utils')

                    -- Determine whether to use linewise or blockwise commentstring
                    local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'

                    -- Determine the location where to calculate commentstring from
                    local location = nil
                    if ctx.ctype == U.ctype.blockwise then
                        location = require('ts_context_commentstring.utils').get_cursor_location()
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = require('ts_context_commentstring.utils').get_visual_start_location()
                    end

                    return require('ts_context_commentstring.internal').calculate_commentstring({
                        key = type,
                        location = location,
                    })
                end
            end,
            post_hook = nil, -- Function to call after (un)comment
        }
    end,
}

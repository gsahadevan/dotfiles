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
            ---Add a space b/w comment and the line
            padding = true,
            ---Whether the cursor should stay at its position
            sticky = true,
            ---Lines to be ignored while (un)comment
            ignore = nil,
            ---LHS of toggle mappings in NORMAL mode
            toggler = {
                ---Line-comment toggle keymap
                line = 'gcc',
                ---Block-comment toggle keymap
                block = 'gbc',
            },
            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                ---Line-comment keymap
                line = 'gc',
                ---Block-comment keymap
                block = 'gb',
            },
            ---LHS of extra mappings
            extra = {
                ---Add comment on the line above
                above = 'gcO',
                ---Add comment on the line below
                below = 'gco',
                ---Add comment at the end of line
                eol = 'gcA',
            },
            ---Enable keybindings
            ---NOTE: If given `false` then the plugin won't create any mappings
            mappings = {
                ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                basic = true,
                ---Extra mapping; `gco`, `gcO`, `gcA`
                extra = true,
            },
            ---Function to call before (un)comment
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
            ---Function to call after (un)comment
            post_hook = nil,
        }
    end,
}

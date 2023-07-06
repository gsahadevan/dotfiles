-- remove all background colors to make nvim transparent.
return {
    'xiyaowong/transparent.nvim',
    config = function()
        require('transparent').setup({
            groups = { -- table: default groups
                'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                'SignColumn', 'CursorLineNr', 'EndOfBuffer',
            },
            extra_groups = {     -- table: additional groups that should be cleared
                'NormalFloat',   -- plugins which have float panel such as Lazy, Mason, LspInfo
                'NvimTreeNormal' -- NvimTree
            },
            exclude_groups = {}, -- table: groups you don't want to clear
        })
    end
}

-- commands available
-- :TransparentEnable
-- :TransparentDisable
-- :TransparentToggle

local status, onedark = pcall(require, 'onedark')
if not status then
    print('onedarkpro is not installed')
    return
end

onedark.setup {
    -- Main options --
    style = 'darker',             -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,          -- Show/hide background
    term_colors = true,           -- Change terminal color as per the selected theme style
    ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil,                                                              -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {},     -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true,     -- darker colors for diagnostic
        undercurl = true,  -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
    },
    -- colors = {
    --     bright_orange = "#ff8800",    -- define a new color
    --     green = '#00ffaa',            -- redefine an existing color
    -- },
    -- highlights = {
    --     ["@keyword"] = {fg = '$green'},
    --     ["@string"] = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
    --     ["@function"] = {fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic'},
    --     ["@function.builtin"] = {fg = '#0059ff'}
    -- }
}

onedark.load()
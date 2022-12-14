vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5
vim.opt.background = 'dark'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
--
-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

-- was placed in tokyonight.rc.lua before
--
-- local colorscheme = 'onedark'
-- -- Lua
-- require('onedark').setup {
--   -- Main options --
--   style = 'deep', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--   transparent = false, -- Show/hide background
--   term_colors = true, -- Change terminal color as per the selected theme style
--   ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
--   cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--
--   -- toggle theme style ---
--   toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
--   toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between
--
--   -- Change code style ---
--   -- Options are italic, bold, underline, none
--   -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
--   code_style = {
--     comments = 'italic',
--     keywords = 'none',
--     functions = 'none',
--     strings = 'none',
--     variables = 'none'
--   },
--
--   -- Lualine options --
--   lualine = {
--     transparent = false, -- lualine center bar transparency
--   },
--
--   -- Custom Highlights --
--   colors = {}, -- Override default colors
--   highlights = {}, -- Override highlight groups
--
--   -- Plugins Config --
--   diagnostics = {
--     darker = true, -- darker colors for diagnostic
--     undercurl = true, -- use undercurl instead of underline for diagnostics
--     background = true, -- use background color for virtual text
--   },
-- }

local colorscheme = 'tokyonight'
local status, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if (not status) then
    print('tokyonight colorscheme not installed')
    return
end

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

--[[
vim.g.tokyonight_colors = {
  fg = "#839496",
  fg_dark = "#586e75",
  fg_gutter = "#073642",
  bg_highlight = "#002b36",
  comment = "#586e75",
  blue = "#268bd2",
    cyan = "#2aa198",
    blue1 = "#2ac3de",
    blue2 = "#0db9d7",
    blue5 = "#89ddff",
    blue6 = "#B4F9F8",
  yellow = "#b58900",
  orange = "#cb4b16",
  magenta = "#d33682",
  purple = "#6c71c4",
}
]]

--vim.cmd[[colorscheme tokyonight]]

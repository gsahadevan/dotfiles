return {
    { 'Yazeed1s/minimal.nvim' },
    { 'sainnhe/edge' },
    { 'lunarvim/horizon.nvim' },
    -- { 'ayu-theme/ayu-vim' }, -- implemented in vim script
    { 'Shatur/neovim-ayu' }, -- A colorscheme for Neovim 0.8+ reimplemented in lua from ayu-vim.
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                --- @usage 'auto'|'main'|'moon'|'dawn'
                variant                  = 'auto',
                --- @usage 'main'|'moon'|'dawn'
                dark_variant             = 'main',
                bold_vert_split          = false,
                dim_nc_background        = false,
                disable_background       = false,
                disable_float_background = false,
                disable_italics          = false,

                --- @usage string hex value or named color from rosepinetheme.com/palette
                groups                   = {
                    background    = 'base',
                    background_nc = '_experimental_nc',
                    panel         = 'surface',
                    panel_nc      = 'base',
                    border        = 'highlight_med',
                    comment       = 'muted',
                    link          = 'iris',
                    punctuation   = 'subtle',

                    error         = 'love',
                    hint          = 'iris',
                    info          = 'foam',
                    warn          = 'gold',

                    headings      = {
                        h1 = 'iris',
                        h2 = 'foam',
                        h3 = 'rose',
                        h4 = 'gold',
                        h5 = 'pine',
                        h6 = 'foam',
                    }
                    -- or set all headings at once
                    -- headings = 'subtle'
                },

                -- Change specific vim highlight groups
                -- https://github.com/rose-pine/neovim/wiki/Recipes
                highlight_groups         = {
                    ColorColumn = { bg = 'rose' },

                    -- Blend colours against the 'base' background
                    CursorLine = { bg = 'foam', blend = 10 },
                    StatusLine = { fg = 'love', bg = 'love', blend = 10 },
                }
            })
        end,
    },
    {
        'gsahadevan/onedark.nvim',
        config = function()
            local onedark = require('onedark')
            onedark.setup {
                -- Main options --
                -- style = 'darker',             -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
                transparent = false,          -- Show/hide background
                term_colors = true,           -- Change terminal color as per the selected theme style
                ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
                cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

                -- toggle theme style ---
                -- toggle_style_key = nil,                                                              -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example '<leader>ts'
                -- toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

                -- Change code style ---
                -- Options are italic, bold, underline, none
                -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
                code_style = {
                    comments  = 'italic',
                    keywords  = 'none',
                    functions = 'none',
                    strings   = 'none',
                    variables = 'none'
                },

                -- Lualine options --
                lualine = {
                    transparent = false, -- lualine center bar transparency
                },

                -- Custom Highlights --
                colors = {}, -- Override default colors
                -- highlights = {}, -- Override highlight groups
                -- colors = {
                --     bright_orange = '#ff8800',    -- define a new color
                --     green = '#00ffaa',            -- redefine an existing color
                -- },
                -- highlights = {
                --     ['@keyword'] = {fg = '$green'},
                --     ['@string'] = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
                --     ['@function'] = {fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic'},
                --     ['@function.builtin'] = {fg = '#0059ff'}
                -- }
                highlights = {
                    ['@comment']        = { fg = 'Gray', fmt = 'italic' },
                    ['Normal']          = { bg = '#1c1d22' },
                    ['NeoTreeNormal']   = { bg = '#1e2227' },
                    ['NeoTreeNormalNC'] = { bg = '#1e2227' },
                },

                -- Plugins Config --
                diagnostics = {
                    darker     = true, -- darker colors for diagnostic
                    undercurl  = true, -- use undercurl instead of underline for diagnostics
                    background = true, -- use background color for virtual text
                },
            }
            -- don't forget to load the colorscheme
            -- onedark.load()
        end
    },
    {
        'Mofiqul/dracula.nvim',
        opts = {
            -- customize dracula color palette
            colors             = {
                bg             = '#282A36',
                fg             = '#F8F8F2',
                selection      = '#44475A',
                comment        = '#6272A4',
                red            = '#FF5555',
                orange         = '#FFB86C',
                yellow         = '#F1FA8C',
                green          = '#50fa7b',
                purple         = '#BD93F9',
                cyan           = '#8BE9FD',
                pink           = '#FF79C6',
                bright_red     = '#FF6E6E',
                bright_green   = '#69FF94',
                bright_yellow  = '#FFFFA5',
                bright_blue    = '#D6ACFF',
                bright_magenta = '#FF92DF',
                bright_cyan    = '#A4FFFF',
                bright_white   = '#FFFFFF',
                menu           = '#21222C',
                visual         = '#3E4452',
                gutter_fg      = '#4B5263',
                nontext        = '#3B4048',
            },
            show_end_of_buffer = true,      -- show the '~' characters after the end of buffers, default false
            transparent_bg     = true,      -- use transparent background, default false
            lualine_bg_color   = '#44475a', -- set custom lualine background color, default nil
            italic_comment     = true,      -- set italic comment, default false
            -- overrides the default highlights see `:h synIDattr`
            overrides          = {
                -- Examples
                -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
                -- NvimTreeIndentMarker = { link = 'NonText' }, -- link to NonText highlight
                -- Nothing = {} -- clear highlight of Nothing
            },
        }
    },
    {
        'EdenEast/nightfox.nvim',
        config = function()
            -- Default options
            require('nightfox').setup({
                options  = {
                    -- Compiled file's destination location
                    compile_path = vim.fn.stdpath('cache') .. '/nightfox',
                    compile_file_suffix = '_compiled', -- Compiled file suffix
                    transparent = false,               -- Disable setting background
                    terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                    dim_inactive = false,              -- Non focused panes set to alternative background
                    module_default = true,             -- Default enable value for modules
                    colorblind = {
                        enable = false,                -- Enable colorblind support
                        simulate_only = false,         -- Only show simulated colorblind colors and not diff shifted
                        severity = {
                            protan = 0,                -- Severity [0,1] for protan (red)
                            deutan = 0,                -- Severity [0,1] for deutan (green)
                            tritan = 0,                -- Severity [0,1] for tritan (blue)
                        },
                    },
                    styles = {
                        -- Style to be applied to different syntax groups
                        comments     = 'italic', -- Value is any valid attr-list value `:help attr-list`
                        conditionals = 'NONE',
                        constants    = 'NONE',
                        functions    = 'NONE',
                        keywords     = 'NONE',
                        numbers      = 'NONE',
                        operators    = 'NONE',
                        strings      = 'NONE',
                        types        = 'NONE',
                        variables    = 'NONE',
                    },
                    inverse = {
                        -- Inverse highlight for different types
                        match_paren = false,
                        visual = false,
                        search = false,
                    },
                    modules = { -- List of various plugins and additional options
                        -- ...
                    },
                },
                palettes = {},
                specs    = {},
                groups   = {},
            })
        end,
    },

}

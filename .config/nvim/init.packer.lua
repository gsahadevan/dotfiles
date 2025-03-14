-- ╭───────────────────────────────────╮
-- │ Add basic options and settings    │
-- ╰───────────────────────────────────╯

vim.cmd('autocmd!') -- clear all autocmds
vim.cmd('language en_US') -- set language to en_US
-- Line numbers, relative numbers
vim.wo.number          = true -- show line numbers
vim.wo.relativenumber  = true -- show relative line numbers
vim.opt.title          = true -- show the title of the file in the window title
vim.opt.showmode       = false -- do not show mode, since it is already shown on status line
vim.opt.showcmd        = true -- show command in bottom right
vim.opt.cmdheight      = 1 -- height of the command bar
vim.opt.laststatus     = 2 -- always show status line
-- Encoding
vim.scriptencoding     = 'utf-8' -- the encoding used for the script
vim.opt.encoding       = 'utf-8' -- the encoding displayed
vim.opt.fileencoding   = 'utf-8' -- the encoding written to file
-- Tabs and spaces
vim.opt.tabstop        = 4 -- number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop    = 4 -- size of an indent in spaces
vim.opt.shiftwidth     = 4 -- size of an indent
vim.opt.expandtab      = true -- use spaces instead of tabs
vim.opt.smarttab       = true -- use shiftwidth for tabstop
-- Line wrap, line break
vim.opt.wrap           = false -- do not wrap lines, display one long line
vim.opt.linebreak      = false -- if wrap is enabled, set to true | donot split words
-- Indentation
vim.opt.autoindent     = true -- keep indentation from previous line
vim.opt.smartindent    = true -- smart autoindenting
vim.opt.breakindent    = true -- indent wrapped lines
-- Chars and other formatting
vim.g.have_nerd_font   = true -- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.indentLine_char  = '┊' -- indentLine '┃'
vim.opt.list           = true -- sets how neovim will display certain whitespace chars in the editor
vim.opt.listchars      = { tab = '» ', trail = '·', nbsp = '␣' } -- set listchars
-- Search and replace
vim.opt.hlsearch       = true -- highlight search results
vim.opt.incsearch      = true -- show search matches as you type
vim.opt.ignorecase     = true -- case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase      = true -- case sensitive searching if any capital letters are used
-- I don't know what this does
vim.opt.inccommand     = 'split' -- preview substitutions live, as you type
vim.opt.signcolumn     = 'yes:3' -- always shows the sign column, otherwise it would shift the text each time
vim.opt.backspace      = { 'start', 'eol', 'indent' } -- backspace behavior
vim.opt.completeopt    = 'menuone,noselect' -- set completeopt to have a better completion experience
vim.opt.clipboard      = 'unnamed' -- copy/paste to system clipboard
-- File backup and undo
vim.opt.backupskip     = { '/tmp/*', '/private/tmp/*' } -- do not backup files in these directories
vim.opt.backup         = false -- disable backup
vim.opt.swapfile       = false -- disable swap files in neovim
vim.opt.undofile       = true -- save undo history
vim.opt.updatetime     = 250 -- decrease update time
-- File folding
vim.opt.foldcolumn     = '1' -- show foldcolumn in nvim 0.9
vim.opt.foldlevel      = 99 -- set high fold level for nvim-ufo
vim.opt.foldlevelstart = 99 -- start with all code unfolded
vim.opt.foldenable     = true -- enable fold for nvim-ufo
-- Config for showing completion menu
vim.opt.wildoptions    = 'pum' -- show popup menu when typing
vim.opt.pumblend       = 0 -- transparency for popup menu
vim.opt.pumheight      = 15 -- completion height, adds scrollbar
vim.opt.pumwidth       = 50 -- completion width
-- Misc options
vim.opt.cursorline     = true -- highlight the current line
vim.opt.termguicolors  = true -- enable 24-bit RGB color in the terminal
-- vim.opt.background     = 'dark'                  -- set the background to dark
-- vim.opt.winblend       = 10                      -- transparency for floating windows
-- vim.opt.winbar         = '%f'                    -- shows the absolute file path on winbar | enabling this would show Nvimtree_1 on explorer
vim.opt.splitright     = true                    -- vertical split to the right
vim.opt.splitbelow     = true                    -- horizontal split to the bottom
vim.opt.path:append { '**' }                     -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' } -- ignore node_modules
vim.opt.formatoptions:append { 'r' }             -- Add asterisks in block comments
vim.opt.rtp:append('/opt/homebrew/opt/fzf')      -- for macos
vim.opt.rtp:append('/usr/bin/fzf')               -- for linux

-- Add diagnostic symbols in the sign column (gutter)
local signs = { Error = '', Hint = '', Info = '', Warn = '' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- To give syntax highlighting for mdx files, similar to md files
vim.filetype.add({
    extension = {
        mdx = 'markdown',
    }
})

-- ╭───────────────────────────────────╮
-- │ Add keymaps                       │
-- ╰───────────────────────────────────╯

-- Modes reference
-- n - normal_mode | i - insert_mode | v - visual_mode | x - visual_block_mode | t - term_mode (terminal) | c - command_mode

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set -- Shorten function name

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Buffers
keymap('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Buffer next' })
keymap('n', '<s-tab>', '<cmd>bprevious<cr>', { desc = 'Buffer prev' })
keymap('n', '<leader>w', '<cmd>bdelete<cr> <bar> <cmd>bprevious<cr>', { desc = 'Buffer close' })
-- keymap('n', '<leader>q', '<cmd>%bdelete<cr> <bar> <cmd>edit#<cr>', { desc = 'Buffer close others' }) -- alternatively :%bd|e#
keymap('n', '<leader>q', '<cmd>CustomCloseOtherBuffers<cr>', { desc = 'Buffer close others' }) -- alternatively :%bd|e#
keymap('n', '<leader>Q', '<cmd>CustomCloseAllBuffers<cr>', { desc = 'Buffer close all' })
keymap('n', '<leader>W', '<cmd>bdelete!<cr> <bar> <cmd>bprevious<cr>', { desc = 'Buffer force close' })
-- Windows
keymap('n', 'sv', '<cmd>vsplit<cr><c-w>w', { noremap = true, silent = true, desc = 'Window split current vertically' })
keymap('n', 'ss', '<cmd>split<cr><c-w>w', { noremap = true, silent = true, desc = 'Window split current horizontally' })
keymap('n', 'sw', '<cmd>close<cr>', { noremap = true, silent = true, desc = 'Window close current' })
keymap('n', 'sr', '<c-w><c-r>', { noremap = true, silent = true, desc = 'Window swap position' })
-- Windows re-sizing
keymap('n', 'se', '<c-w>=', { noremap = true, silent = true, desc = 'Window make all equal size' })
keymap('n', 'sz', '<c-w>_ | <c-w>|', { noremap = true, silent = true, desc = 'Window zoom current split' })
keymap('n', '<c-w>.', '<c-w>5>', { noremap = true, silent = true, desc = 'Window increase width' })
keymap('n', '<c-w>,', '<c-w>5<', { noremap = true, silent = true, desc = 'Window decrease width' })
keymap('n', '<c-w>t', '<c-w>+', { noremap = true, silent = true, desc = 'Window increase height' })
keymap('n', '<c-w>s', '<c-w>-', { noremap = true, silent = true, desc = 'Window decrease height' })
-- Selection and highlighting
keymap('n', '<leader>a', 'gg<S-v>G', { noremap = true, silent = true, desc = 'Select all text in buffer' })
keymap('n', '<esc>', '<cmd>nohl<cr>', { noremap = true, silent = true, desc = 'No (Remove) search highlighting' })
-- Stay in visual mode while indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
-- Move visually selected text up and down
keymap('v', 'J', ':m \'>+1<cr>gv=gv', opts)                                                                        -- in normal mode J -> joins lines
keymap('v', 'K', ':m \'<-2<cr>gv=gv', opts)                                                                        -- in normal mode K -> LSP show hover doc
-- keymap('n', '<leader>tt', ':belowright split | resize 15 | terminal<cr>', { desc = 'Open terminal window' })       -- Some other options are :topleft split | terminal or :vsplit | terminal or :split | resize 20 | term
keymap('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Exit terminal mode (enter normal mode on terminal) with esc' }) -- Easily hit escape in terminal mode
-- Open terminal at the bottom of the screen with a fixed height
-- Does the same as <leader>tt before
local term_id = 0
keymap('n', '<leader>tt', function()
    vim.cmd.new()
    vim.cmd.wincmd('J')
    vim.api.nvim_win_set_height(0, 15)
    vim.wo.winfixheight = true
    vim.cmd.term()
    term_id = vim.bo.channel
end)
-- Send commands to terminal
keymap('n', '<leader>ttt', function()
    vim.fn.chansend(term_id, { "pnpm test\r" })
end, { desc = 'Run tests in terminal' })
-- Command mode
keymap('c', 'Q', 'q')   -- replace Q with q on the command mode
keymap('c', 'Qa', 'qa') -- replace Qa with qa on the command mode
-- Misc
keymap('n', '<leader>pv', vim.cmd.Explore, { desc = 'Open Netrw directory listing' })
keymap('n', 'cp', '<cmd>let @+ = expand("%p")<cr>', { desc = 'Copy absolute file path' })
keymap('n', ',f', '<cmd>%s/"/\'/g<cr>', { desc = 'Format replace " with \'' })
-- Position of the cursor relative to the screen
-- cnoremap <expr> <CR> getcmdtype() == '/' ? '<CR>zz' : '<CR>' -- can also be done using this command
keymap('c', '<cr>', function()
    return vim.fn.getcmdtype() == '/' and '<cr>zz' or '<cr>'
end, { expr = true, desc = 'Keeps cursor in the middle of the screen on first occurrence of next search match' })
-- cnoremap <expr> <CR> getcmdtype() == '?' ? '<CR>zz' : '<CR>' -- can also be done using this command
keymap('c', '<cr>', function()
    return vim.fn.getcmdtype() == '?' and '<cr>zz' or '<cr>'
end, { expr = true, desc = 'Keeps cursor in the middle of the screen on first occurrence of previous search match' })
keymap('n', '*', function() vim.cmd('normal! *zz') end, { desc = 'Keeps cursor in the middle on next occurrence' })
keymap('n', '#', function() vim.cmd('normal! #zz') end, { desc = 'Keeps cursor in the middle on previous occurrence' })
keymap('n', 'n', 'nzzzv', { desc = 'Keeps cursor in the middle for next occurrence of search terms' })
keymap('n', 'N', 'Nzzzv', { desc = 'Keeps cursor in the middle for previosu occurence of search terms' })
keymap('n', 'J', 'mzJ`z', { desc = 'Keeps cursor in place when joining lines' })
keymap('n', '<c-d>', '<c-d>zz', { desc = 'Keeps cursor in the middle of screen' })
keymap('n', '<c-u>', '<c-u>zz', { desc = 'Keeps cursor in the middle of screen' })
-- Preserve pasted in buffer
keymap('v', '<leader>p', '"_dp', { desc = 'Preserve pasted in buffer - visual mode' })
keymap('x', '<leader>p', '"_dp', { desc = 'Preserve pasted in buffer - visual block mode' })
keymap('n', 'x', '"_x', { desc = 'Do not save characters cut using x' })

-- ╭───────────────────────────────────╮
-- │ Custom commands                   │
-- ╰───────────────────────────────────╯

-- Function to close all other buffers except the current one
-- local function close_other_buffers()
--     local current_buf = vim.api.nvim_get_current_buf()
--     for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--         if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
--             vim.api.nvim_buf_delete(buf, { force = false })
--         end
--     end
-- end
-- -- Command to close all other buffers except the current one
-- vim.api.nvim_create_user_command('CustomCloseOtherBuffers', close_other_buffers,
--     { desc = 'Close all other buffers except the current one' })

-- Function to close all other buffers except the current one, with a warning for unsaved changes
local function close_other_buffers()
    local unsaved_buffers = {}
    local current_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
            local modified = vim.api.nvim_get_option_value('modified', { buf = buf })
            if modified then
                table.insert(unsaved_buffers, buf)
            else
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end
    if #unsaved_buffers > 0 then
        local buffer_names = {}
        for _, buf in ipairs(unsaved_buffers) do
            table.insert(buffer_names, vim.api.nvim_buf_get_name(buf))
        end
        local message = 'Unsaved changes in buffers:\n' .. table.concat(buffer_names, '\n')
        print(message)
    end
end
-- Command to close all other buffers except the current one
vim.api.nvim_create_user_command('CustomCloseOtherBuffers', close_other_buffers,
    { desc = 'Close all other buffers except the current one, warn about unsaved changes' })

-- -- Function to close all buffers
-- local function close_all_buffers()
--     for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--         if vim.api.nvim_buf_is_loaded(buf) then
--             vim.api.nvim_buf_delete(buf, { force = false })
--         end
--     end
-- end
-- -- Command to close all buffers
-- vim.api.nvim_create_user_command('CustomCloseAllBuffers', close_all_buffers, { desc = 'Close all buffers' })

-- Function to close all buffers with a warning for unsaved changes
local function close_all_buffers()
    local unsaved_buffers = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            local modified = vim.api.nvim_get_option_value('modified', { buf = buf })
            if modified then
                table.insert(unsaved_buffers, buf)
            else
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end
    end
    if #unsaved_buffers > 0 then
        local buffer_names = {}
        for _, buf in ipairs(unsaved_buffers) do
            table.insert(buffer_names, vim.api.nvim_buf_get_name(buf))
        end
        local message = 'Unsaved changes in buffers:\n' .. table.concat(buffer_names, '\n')
        print(message)
    end
end
-- Command to close all buffers
vim.api.nvim_create_user_command('CustomCloseAllBuffers', close_all_buffers,
    { desc = 'Close all buffers, warn about unsaved changes' })

-- Function to change the colorscheme
local function change_colorscheme(themes)
    vim.api.nvim_command('colorscheme ' .. themes.args)
    require('lualine').setup { options = { theme = themes.args } }
    require('lualine').refresh()
end
-- Function to get available colorschemes for completion
local function colorscheme_completion(current_input)
    local themes = {}
    for _, name in ipairs(vim.fn.getcompletion(current_input, 'color')) do
        table.insert(themes, name)
    end
    return themes
end
-- Command to change the colorscheme
vim.api.nvim_create_user_command('CustomChangeColorscheme', change_colorscheme,
    { nargs = 1, complete = colorscheme_completion, desc = 'Change the colorscheme' })

-- ╭───────────────────────────────────╮
-- │ Install packer                    │
-- ╰───────────────────────────────────╯

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

-- ╭───────────────────────────────────╮
-- │ Install packages                  │
-- ╰───────────────────────────────────╯

require('packer').startup({
    function(use)
        use { 'wbthomason/packer.nvim' }                      -- packer can manage itself
        use { 'numToStr/Comment.nvim' }                       -- smart and powerful commenting plugin for neovim
        use { 'JoosepAlviste/nvim-ts-context-commentstring' } -- sets commentstring option based on the cursor location, checked via treesitter queries
        use { 'folke/ts-comments.nvim' }                      -- tiny plugin to enhance neovim 0.10.0 native comments
        use { 'nvim-tree/nvim-tree.lua',
            requires = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }
        }                                             -- a file explorer for nvim written in lua
        use { 'lukas-reineke/indent-blankline.nvim' } -- adds indentation guides to all lines (including empty lines), using nvim's virtual text feature
        use { 'catppuccin/nvim', as = 'catppuccin' }  -- primary colorscheme
        use { 'arzg/vim-colors-xcode' }               -- secondary colorscheme
        use { 'projekt0n/github-nvim-theme' }         -- alternative colorscheme
        -- use { 'Mofiqul/dracula.nvim' }                                                                 -- alternative colorscheme
        -- use { 'navarasu/onedark.nvim' }                                                                -- alternative colorscheme
        use { 'nvim-lualine/lualine.nvim' }                                                            -- statusline written in lua
        use { 'nvim-telescope/telescope.nvim', tag = '0.1.6', requires = { 'nvim-lua/plenary.nvim' } } -- fuzzy finder for files
        use { 'nvim-telescope/telescope-symbols.nvim' }                                                -- find emojis with telescope :Telescope symbols
        use { 'nvim-telescope/telescope-ui-select.nvim' }                                              -- neovim core stuffs can fill telescope
        use { 'nvim-telescope/telescope-frecency.nvim' }                                               -- change the sorting algorithm to fuzzy find files using telescope
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v2.x',
            requires = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' },
                { 'williamboman/mason.nvim' },
                { 'williamboman/mason-lspconfig.nvim' },
                -- Autocompletion
                { 'hrsh7th/nvim-cmp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'hrsh7th/cmp-cmdline' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'L3MON4D3/LuaSnip',                 run = 'make install_jsregexp' },
                { 'rafamadriz/friendly-snippets' },
                { 'saadparwaiz1/cmp_luasnip' },
            }
        }
        use { 'nvimdev/lspsaga.nvim' }
        -- use { 'ray-x/lsp_signature.nvim' }                                              -- show function signature while typing
        use { 'dinhhuy258/git.nvim' }                                                   -- git browse and blame
        use { 'lewis6991/gitsigns.nvim' }                                               -- show git file modification signs on gutter
        use { 'sindrets/diffview.nvim' }                                                -- single tabpage interface for easily cycling through git diffs
        use { 'christoomey/vim-tmux-navigator' }                                        -- seamlessly move btw nvim panes and tmux
        use { 'nvim-treesitter/nvim-treesitter' }                                       -- also required for nvim-ufo, nvim-ts-autotag
        use { 'windwp/nvim-autopairs' }                                                 -- powerful autopair plugin that supports multiple characters
        use { 'windwp/nvim-ts-autotag' }                                                -- use treesitter to autoclose and autorename html tag
        use { 'kylechui/nvim-surround' }                                                -- surround selections, in style
        use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }            -- general purpose command line fuzzy finder
        use { 'norcalli/nvim-colorizer.lua' }                                           -- high performance color highlighter
        use { 'kevinhwang91/nvim-bqf' }                                                 -- make neovim's quickfix window better
        use { 'petertriho/nvim-scrollbar', requires = { 'kevinhwang91/nvim-hlslens' } } -- extensible neovim scrollbar
        use { 'kevinhwang91/nvim-ufo', requires = { 'kevinhwang91/promise-async' } }    -- makes nvim's fold look modern and keep high performance
        -- use { 'xiyaowong/transparent.nvim' }                                            -- if terminal is transparent, toggle neovim transparency by :TransparencyToggle
        use { 'mfussenegger/nvim-dap' }                                                 -- debug adapter protocol client implementation for neovim
        use { 'mxsdev/nvim-dap-vscode-js' }
        use { 'github/copilot.vim' }                                                    -- neovim plugin for GitHub copilot

        if is_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'rounded' })
            end
        }
    }
})

-- When we are bootstrapping a configuration, it doesn't make sense to execute the rest of the init.lua.
-- restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed   '
    print '    Wait until Packer completes,  '
    print '       then restart nvim          '
    print '=================================='
    return
end

-- ╭───────────────────────────────────╮
-- │ Add autocommands                  │
-- ╰───────────────────────────────────╯

-- Automatically source and re-compile packer whenever you save this init.lua
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = vim.api.nvim_create_augroup('Packer', { clear = true }),
    pattern = vim.fn.expand '$MYVIMRC',
})
-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
    pattern = '*',
    command = 'set nopaste'
})
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('CustomTermOpen', {}),
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.opt.scrolloff = 0
        vim.wo.cursorline = false
        vim.wo.cursorcolumn = false
        vim.wo.foldcolumn = '0'
        vim.wo.list = false
        vim.wo.signcolumn = 'no'
        vim.wo.wrap = false
    end,
})

-- ╭───────────────────────────────────╮
-- │ Configure packages                │
-- ╰───────────────────────────────────╯

-- Configure comment
require('Comment').setup {
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
-- require('Comment').setup()
-- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
-- Contains the complete configuration list is for nvim-tree
require('ts-comments').setup({})
require('nvim-tree').setup({
    view = {
        centralize_selection = true,
        width = 55,
        preserve_window_proportions = true,
    },
    update_focused_file = {
        enable = true,
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
        },
    },
    modified = {
        enable = true,
    },
    filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {
            '.*/node_modules/.*',
            '.git',
            '.nx'
        },
    },
})
keymap('n', '<leader>b', '<cmd>NvimTreeToggle<cr>', { desc = 'NvimTree toggle' })
-- Configure indent-blankline
require('ibl').setup {
    indent = { char = '┊' },
    whitespace = {
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}
-- Configure catppuccin colorscheme
require('catppuccin').setup({
    flavour = 'auto', -- latte, frappe, macchiato, mocha
    background = {    -- :h background
        light = 'latte',
        dark = 'mocha',
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
    term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false,            -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15,          -- percentage of the shade to apply to the inactive window
    },
    no_italic = false,              -- Force no italic
    no_bold = false,                -- Force no bold
    no_underline = false,           -- Force no underline
    styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' },    -- Change the style of comments
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = { 'italic' },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    -- custom_highlights = {},
    custom_highlights = function(colors)
        return {
            TabLineSel = { bg = colors.pink },
            CmpBorder = { fg = colors.surface2 },
            Pmenu = { bg = colors.none },
            CursorLine = { bg = colors.surface0 },
        }
    end,
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        lsp_saga = true,
        mini = {
            enabled = true,
            indentscope_color = '',
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})
-- vim.api.nvim_command('colorscheme catppuccin-frappe') -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
-- Configure dracula colorscheme
-- require('dracula').setup({
--     -- customize dracula color palette
--     colors = {
--         bg = "#282A36",
--         fg = "#F8F8F2",
--         selection = "#44475A",
--         comment = "#6272A4",
--         red = "#FF5555",
--         orange = "#FFB86C",
--         yellow = "#F1FA8C",
--         green = "#50fa7b",
--         purple = "#BD93F9",
--         cyan = "#8BE9FD",
--         pink = "#FF79C6",
--         bright_red = "#FF6E6E",
--         bright_green = "#69FF94",
--         bright_yellow = "#FFFFA5",
--         bright_blue = "#D6ACFF",
--         bright_magenta = "#FF92DF",
--         bright_cyan = "#A4FFFF",
--         bright_white = "#FFFFFF",
--         menu = "#21222C",
--         visual = "#3E4452",
--         gutter_fg = "#4B5263",
--         nontext = "#3B4048",
--         white = "#ABB2BF",
--         black = "#191A21",
--     },
--     -- show the '~' characters after the end of buffers
--     show_end_of_buffer = true,  -- default false
--     -- use transparent background
--     transparent_bg = true,      -- default false
--     -- set custom lualine background color
--     lualine_bg_color = "#44475a", -- default nil
--     -- set italic comment
--     italic_comment = true,      -- default false
--     -- overrides the default highlights with table see `:h synIDattr`
--     overrides = {},
--     -- You can use overrides as table like this
--     -- overrides = {
--     --   NonText = { fg = "white" }, -- set NonText fg to white
--     --   NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
--     --   Nothing = {} -- clear highlight of Nothing
--     -- },
--     -- Or you can also use it like a function to get color from theme
--     -- overrides = function (colors)
--     --   return {
--     --     NonText = { fg = colors.white }, -- set NonText fg to white of theme
--     --   }
--     -- end,
-- })
-- vim.api.nvim_command('colorscheme xcode') -- dracula-soft
-- Configure onedark colorscheme
-- require('onedark').setup {
--     -- Main options --
--     style = 'dark',               -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--     transparent = false,          -- Show/hide background
--     term_colors = true,           -- Change terminal color as per the selected theme style
--     ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
--     cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--
--     -- toggle theme style ---
--     toggle_style_key = nil,                                                              -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
--     toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between
--
--     -- Change code style ---
--     -- Options are italic, bold, underline, none
--     -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
--     code_style = {
--         comments = 'italic',
--         keywords = 'none',
--         functions = 'none',
--         strings = 'none',
--         variables = 'none'
--     },
--
--     -- Lualine options --
--     lualine = {
--         transparent = false, -- lualine center bar transparency
--     },
--
--     -- Custom Highlights --
--     colors = {},     -- Override default colors
--     highlights = {}, -- Override highlight groups
--
--     -- Plugins Config --
--     diagnostics = {
--         darker = true,     -- darker colors for diagnostic
--         undercurl = true,  -- use undercurl instead of underline for diagnostics
--         background = true, -- use background color for virtual text
--     },
-- }
-- require('onedark').load()
-- vim.api.nvim_command('colorscheme github_light')
vim.api.nvim_command('colorscheme catppuccin-frappe')
-- Configure lualine
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = {
            statusline = { 'packer', 'NvimTree', 'mason' },
            winbar = { 'packer', 'NvimTree', 'mason' },
        },
        globalstatus = true,
    },
    sections = {
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
            {
                'diagnostics',
                sections = { 'error', 'warn' },
                symbols = {
                    error = ' ',
                    warn  = ' ',
                    info  = ' ',
                    hint  = ' ',
                },
            },
        },
    },
    inactive_sections = {
        lualine_c = {},
    },
    tabline = {
        lualine_c = {
            {
                'buffers',
                mode = 0,                   -- 0: name, 1: index, 2: name + index, 3: number, 4: name + number
                max_length = vim.o.columns, -- max_length = vim.o.columns * 2 / 3,
                filetype_names = {
                    TelescopePrompt = 'Telescope',
                    dashboard = 'Dashboard',
                    packer = 'Packer',
                    fzf = 'FZF',
                    alpha = 'Alpha',
                    NvimTree = 'Explore',
                    netrw = 'Explore',
                },
                use_mode_colors = false,
                buffers_color = {
                    active = { fg = 'black', bg = '#ca9ee6' },
                    inactive = {},
                },
            },
        },
    },
}
-- Configure telescope + add keymaps
require('telescope').setup {
    defaults = {
        prompt_prefix = '❯ ',
        layout_config = {
            height = 0.95,
            width = 0.95,
        },
        path_display = { 'filename_first' },
        mappings = {
            n = {
                ['<c-w>'] = require('telescope.actions').delete_buffer,
            },
            i = {
                ['<c-w>'] = require('telescope.actions').delete_buffer,
            },
        },
        file_ignore_patterns = { 'node_modules' }
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
        },
        frecency = {
            theme = 'dropdown',
            show_scores = true,
        },
        ['ui-select'] = {
            require('telescope.themes').get_dropdown {}
        },
    },
}
-- require('telescope').load_extension('fzf')
-- pcall('fzf', require('telescope').load_extension)
-- require('telescope').load_extension('frecency')
-- require('telescope').load_extension('ui-select')
-- pcall('frecency', require('telescope').load_extension)
pcall(require('telescope').load_extension, 'frecency')
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
local _, telescope = pcall(require, 'telescope')
if telescope then
    local builtin = require('telescope.builtin')
    local themes = require('telescope.themes')

    -- intention is to pass options to the existing pickers
    -- ref: https://github.com/nvim-telescope/telescope.nvim/issues/848
    local options = themes.get_dropdown {
        path_display = { 'filename_first' },
        winblend = 0,      -- transparency for floating window, 0 - opaque | 100 - transparent
        previewer = false, -- do not show previewer for dropdown style here
        layout_config = {
            height = 0.6,
            width = 0.8,
        },
    }

    local buffer_fuzzy_find = function()
        builtin.current_buffer_fuzzy_find(options)
    end

    local find_open_buffers = function()
        builtin.buffers(options)
    end

    local find_files_all = function()
        builtin.find_files {
            hidden = true,
            no_ignore = true
        }
    end

    local find_files_wo_preview = function()
        builtin.find_files(options)
    end

    local grep_search_all = function()
        builtin.live_grep {
            additional_args = function(args)
                return vim.list_extend(args, { '--hidden', '--no-ignore' })
            end,
        }
    end

    local grep_search_args = function()
        telescope.extensions.live_grep_args.live_grep_args()
    end

    local show_lsp_definition_in_split = function()
        builtin.lsp_definitions({ jump_type = 'vsplit' })
    end

    local frecency_options = themes.get_dropdown {
        workspace = 'CWD', -- frecency scope is limited to current working directory
        path_display = { 'filename_first' },
        winblend = 0,      -- transparency for floating window, 0 - opaque | 100 - transparent
        previewer = false, -- do not show previewer for dropdown style here
        layout_config = {
            height = 0.6,
            width = 0.8,
        },
    }
    -- Can also be done with <cmd>Telescope frecency workspace=CWD<cr>
    local show_frecency_workspace_cwd = function()
        telescope.extensions.frecency.frecency(frecency_options)
    end

    local marks_options = themes.get_dropdown {
        initial_mode = 'normal',
        path_display = { 'filename_first' },
        winblend = 0,      -- transparency for floating window, 0 - opaque | 100 - transparent
        previewer = false, -- do not show previewer for dropdown style here
        layout_config = {
            height = 0.6,
            width = 0.8,
        },
    }

    local show_marks = function()
        builtin.marks(marks_options)
    end

    -- See `:help telescope.builtin`
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    keymap('n', '<leader>/', buffer_fuzzy_find, { desc = 'Telescope fuzzy search in curr. buffer' })
    keymap('n', '<leader>?', builtin.oldfiles, { desc = 'Telescope find recently opened files' })
    keymap('n', '<leader><space>', find_open_buffers, { desc = 'Telescope show existing buffers' })

    keymap('n', '<leader>f<cr>', builtin.resume, { desc = 'Telescope find, resume previous search' })
    keymap('n', '<leader>fp', builtin.find_files, { desc = 'Telescope find files with preview' })
    keymap('n', '<leader>fP', find_files_all, { desc = 'Telescope find files with preview incl. hidden' })
    keymap('n', '<leader>fr', find_files_wo_preview, { desc = 'Telescope find files without preview' })
    keymap('n', '<leader>ff', show_frecency_workspace_cwd, { desc = 'Telescope find files with frecency' })
    keymap('n', '<leader>fm', show_marks, { desc = 'Telescope show marks without preview' })

    keymap('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope search using live grep' })
    keymap('n', '<leader>sG', grep_search_all, { desc = 'Telescope search using live grep incl. hidden' })
    keymap('n', '<leader>fG', grep_search_args, { desc = 'Telescope search using live grep incl. args' })
    keymap('n', '<leader>sw', builtin.grep_string, { desc = 'Telescope search for word under cursor' })
    -- git
    keymap('n', '<leader>tgb', builtin.git_branches, { desc = 'Telescope list git branches' })
    keymap('n', '<leader>tgc', builtin.git_commits, { desc = 'Telescope list git commits' })
    keymap('n', '<leader>tgf', builtin.git_files, { desc = 'Telescope list git files' })
    keymap('n', '<leader>tgs', builtin.git_status, { desc = 'Telescope list git status' })
    -- misc
    keymap('n', '<leader>tsd', builtin.diagnostics, { desc = 'Telescope show diagnostics' })
    keymap('n', '<leader>tsr', builtin.registers, { desc = 'Telescope show registers' })
    keymap('n', '<leader>tsm', builtin.marks, { desc = 'Telescope show marks' })
    keymap('n', '<leader>tsj', builtin.jumplist, { desc = 'Telescope show jump list' })
    keymap('n', '<leader>tsk', builtin.keymaps, { desc = 'Telescope show keymaps' })
    -- lsp
    keymap('n', '<leader>vd', show_lsp_definition_in_split, { desc = 'Telescope LSP go to definition in vsplit' })
    keymap('n', '<leader>tld', builtin.lsp_definitions, { desc = 'Telescope LSP show definitions' })
    keymap('n', '<leader>tli', builtin.lsp_implementations, { desc = 'Telescope LSP show implementations' })
    keymap('n', '<leader>tlr', builtin.lsp_references, { desc = 'Telescope LSP show references' })
    keymap('n', '<leader>tls', builtin.lsp_document_symbols, { desc = 'Telescope LSP show document symbols' })
    keymap('n', '<leader>tlw', builtin.lsp_workspace_symbols, { desc = 'Telescope LSP show workspace symbols' })
end
-- Configure LSP
local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({
        buffer = bufnr,
        -- preserve_mappings = false -- read here for more understanding - https://github.com/VonHeikemen/lsp-zero.nvim#keybindings
    })
end)
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls()) -- (optional) configure lua language server for neovim
require('lspconfig.ui.windows').default_options.border = 'rounded'
lsp.setup()
-- Configure Lspsaga
-- For more info - https://nvimdev.github.io/lspsaga/
require('lspsaga').setup({
    border_style = 'rounded',
    ui = {
        border = 'rounded',
        kind = require('catppuccin.groups.integrations.lsp_saga').custom_kind(),
    },
    hover = {
        max_width = 0.6,
        max_height = 0.5,
    },
    finder = {
        max_height = 0.5,
        left_width = 0.3,
        default = 'tyd+ref+imp+def',
        keys = {
            shuttle = '[w',
            toggle_or_open = 'o',
            vsplit = 's',
            split = 'i',
            tabe = 't',
            tabnew = 'r',
            quit = 'q',
            close = '<C-c>k',
        },
    },
    symbol_in_winbar = {
        separator = ' ⮁ ',
        ignore_patterns = {},
        hide_keyword = true,
        show_file = true,
        folder_level = 6,
        respect_root = false,
        color_mode = true,
    },
})
-- Add keymaps for Lspsaga
keymap('n', 'K', '<cmd>Lspsaga hover_doc<cr>',
    { nowait = true, noremap = true, silent = true, desc = 'Show hover info of symbol under cursor' })
keymap('n', 'gh', '<cmd>Lspsaga finder<cr>', { noremap = true, silent = true, desc = 'Show LSP finder' })
keymap('n', '<leader>o', '<cmd>Lspsaga outline<cr>', { noremap = true, silent = true, desc = 'Open sysmbols outline' })
keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>',
    { noremap = true, silent = true, desc = 'Show code action available for cursor pos' }) -- changed from <f4>
-- Lspsaga call heirarchy
keymap('n', '<leader>ci', '<cmd>Lspsaga incoming_calls<cr>',
    { noremap = true, silent = true, desc = 'Show incoming call heirarchy' })
keymap('n', '<leader>co', '<cmd>Lspsaga outgoing_calls<cr>',
    { noremap = true, silent = true, desc = 'Show outgoing call heirarchy' })
-- Lspsaga definitions
keymap('n', 'gd', '<cmd>Lspsaga goto_definition<cr>',
    { nowait = true, noremap = true, silent = true, desc = 'Lspsaga goto definition' })
keymap('n', 'gD', '<cmd>Lspsaga peek_definition<cr>',
    { nowait = true, noremap = true, silent = true, desc = 'Lspsaga peek definition' })
keymap('n', 'gt', '<cmd>Lspsaga goto_type_definition<cr>',
    { nowait = true, noremap = true, silent = true, desc = 'Lspsaga goto type definition' })
keymap('n', 'gT', '<cmd>Lspsaga peek_type_definition<cr>',
    { nowait = true, noremap = true, silent = true, desc = 'Lspsaga peek type definition' })
-- Lspsaga diagnostics
keymap('n', 'sl', '<cmd>Lspsaga show_line_diagnostics<cr>',
    { noremap = true, silent = true, desc = 'Show line diagnostics' })
keymap('n', 'sc', '<cmd>Lspsaga show_cursor_diagnostics<cr>',
    { noremap = true, silent = true, desc = 'Show cursor diagnostics' })
keymap('n', 'sb', '<cmd>Lspsaga show_buf_diagnostics<cr>',
    { noremap = true, silent = true, desc = 'Show buffer diagnostics' })
keymap('n', 'g]', '<cmd>Lspsaga diagnostic_jump_prev<cr>',
    { noremap = true, silent = true, desc = 'Move to the prev diagnostic in current buffer' })
keymap('n', 'g[', '<cmd>Lspsaga diagnostic_jump_next<cr>',
    { noremap = true, silent = true, desc = 'Move to the next diagnostic in current buffer' })
-- Lspsaga misc
keymap('n', '<leader>cr', '<cmd>Lspsaga rename<cr>',
    { noremap = true, silent = true, desc = 'Renames all references of symbol under cursor' })
keymap('n', '<leader>cf', vim.lsp.buf.format, { noremap = true, silent = true, desc = 'Format code in current buffer' })
keymap('n', '<leader>cq', vim.diagnostic.setloclist,
    { noremap = true, silent = true, desc = 'Open diagnostic set loc list' })
-- https://stackoverflow.com/questions/67988374/neovim-lsp-auto-fix-fix-current
-- To make sure you only apply relevant fixes, you can use the filter attribute and look for the "prefered" fixes.
local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end
vim.keymap.set('n', '<leader>qf', quickfix,
    { noremap = true, silent = true, desc = 'Format code by applying quickfix on code actions' })
-- Configure completion
-- You need to setup `cmp` after lsp-zero
--
-- Required for logging / testing
-- local log = require('plenary.log').new({
--     level = 'debug'
-- })
-- Call the logging by log.debug('----------')
-- logs would be found in :messages
--
local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 25
local MIN_LABEL_WIDTH = 25
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
require('luasnip')
require('luasnip.loaders.from_vscode').load {}
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users
        end,
    },
    mapping = {
        -- `Enter` key to confirm completion
        ['<cr>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', },
        { name = 'buffer',  keyword_length = 3 },
        { name = 'path',    keyword_length = 3 },
    },
    window = {
        completion = cmp.config.window.bordered({
            winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:Search' }),
        documentation = cmp.config.window.bordered({
            winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:Search' }),
        preview = cmp.config.window.bordered({
            winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:Search' }),
        col_offset = -3,
        side_padding = 0,
        max_width = 100,
        min_width = 100,
    },
    formatting = {
        -- fields = { 'abbr', 'kind', 'menu' },
        fields = { 'abbr', 'menu' },
        format = function(entry, vim_item)
            -- add ellipsis and extra padding to match the width
            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            if truncated_label ~= label then
                vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
            elseif string.len(label) < MIN_LABEL_WIDTH then
                local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
                vim_item.abbr = label .. padding
            end
            -- Add the kind, check if you could somehow add icons
            -- Would help save some space
            vim_item.kind = string.format('%s', vim_item.kind)
            -- Add vscode style export names at the end
            -- Again, source name might not be required
            local return_type = entry:get_completion_item()
            local source_name = ({
                nvim_lsp = '_lsp ',
                nvim_lua = '_lua ',
                luasnip  = 'snip ',
                buffer   = 'bufr ',
                path     = 'path ',
            })[entry.source.name]
            if return_type ~= nil and return_type.data ~= nil and return_type.data.entryNames ~= nil then
                -- if return_type.data.entryNames[1] ~= nil and return_type.data.entryNames[1].data ~= nil and return_type.data.entryNames[1].data.exportName ~= nil then
                if return_type.data.entryNames[1] ~= nil and return_type.data.entryNames[1].source ~= nil then
                    -- log.debug('------------------------------------')
                    -- log.debug('name: ' .. vim_item.abbr)
                    -- log.debug(return_type)
                    -- vim_item.menu = return_type.data.entryNames[1].data.exportName
                    vim_item.menu = return_type.data.entryNames[1].source
                else
                    vim_item.menu = source_name
                end
            else
                vim_item.menu = source_name
            end

            local menu = vim_item.menu
            local truncated_menu = vim.fn.strcharpart(menu, 0, MAX_LABEL_WIDTH)
            if truncated_menu ~= menu then
                vim_item.menu = truncated_menu .. ELLIPSIS_CHAR
            elseif string.len(menu) < MIN_LABEL_WIDTH then
                local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(menu))
                vim_item.menu = menu .. padding
            end

            return vim_item
        end,
    },
})
-- Disable lsp_signature, causing issues in the work project folder
-- Configure lsp_signature
-- require 'lsp_signature'.setup({
--     bind = true,
--     handler_opts = {
--         border = 'rounded'
--     },
-- })
-- local show_toggle_float_window = function()
--     require('lsp_signature').toggle_float_win()
-- end
-- keymap('n', '<c-k>', show_toggle_float_window, { silent = true, noremap = true, desc = 'LSP toggle signature' })
-- Configure mason
require('mason').setup({
    ui = {
        border = 'rounded',
        height = 0.95,
        width = 0.95,
    }
})
-- Configure git
require('git').setup({
    default_mappings = true,  -- NOTE: `quit_blame` and `blame_commit` are still merged to the keymaps even if `default_mappings = false`
    target_branch = 'master', -- Default target branch when create a pull request
})
local _, git = pcall(require, 'Git')
if git then
    keymap('n', '<leader>gb', function() require('git.blame').blame() end, { desc = 'Git open blame window' })
    keymap('n', '<leader>gd', function() require('git.diff').open() end, { desc = 'Git open diff window' })
    keymap('n', '<leader>gD', function() require('git.diff').close() end, { desc = 'Git close diff window' })
    keymap('n', '<leader>gn', function() require('git.browse').create_pull_request() end,
        { desc = 'Git create a pull request' })
    keymap('n', '<leader>go', function() require('git.browse').open(false) end,
        { desc = 'Git open file / folder in repo' })
    keymap('n', '<leader>gp', function() require('git.browse').pull_request() end,
        { desc = 'Git open pull request of current branch' })
end
require('gitsigns').setup({
    signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '     <author>, <author_time:%d-%m-%Y> • <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,  -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    -- Options passed to nvim_open_win
    preview_config = {
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
        height = 20,
    },
})
local _, gitsigns = pcall(require, 'gitsigns')
if gitsigns then
    -- Disabled current line blame by default, use this key combination to enable it if required
    keymap('n', '<leader>gmt', gitsigns.toggle_current_line_blame, { desc = 'Git toggle current line blame' })
    keymap('n', '<leader>h]', gitsigns.next_hunk, { desc = 'Git hunk next' })
    keymap('n', '<leader>h[', gitsigns.prev_hunk, { desc = 'Git hunk prev' })
    keymap('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Git hunk preview' })
    keymap('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git hunk stage' })
    keymap('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Git hunk unstage' })
    keymap('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git hunk reset' })
end
-- Configure other misc packages
-- diffview gives some default keymaps on the merge_tool
-- :DiffviewOpen to open the mege_tool during merge or rebase to list the conflicted files
-- The default mapping `g<C-x>` allows you to cycle through the available layouts
--
-- You can jump between conflict markers with `]x` and `[x`
--
-- Additionally there are mappings for operating directly on the conflict markers:
--   • `<leader>co`: Choose the OURS version of the conflict.
--   • `<leader>ct`: Choose the THEIRS version of the conflict.
--   • `<leader>cb`: Choose the BASE version of the conflict.
--   • `<leader>ca`: Choose all versions of the conflict (effectively
--     just deletes the markers, leaving all the content).
--   • `dx`: Choose none of the versions of the conflict (delete the
--     conflict region).
require('diffview').setup({
    view = {
        merge_tool = {
            layout = 'diff3_mixed', -- default layout is diff3_horizontal
        },
    },
})
require('bqf').setup({
    auto_enable = true,
    auto_resize_height = true,
    preview = {
        auto_preview = true,
        border = 'rounded',
        show_title = true,
        show_scroll_bar = true,
        delay_sntax = 80,
        win_height = 999, -- height of the preview window for horizontal layout, default is 15, use 999 for full mode
        win_vheight = 999,
        winblend = 0,
        wrap = false,
        buf_label = true,
        should_preview_cb = nil,
    },
    filter = {
        fzf = {
            ['ctrl-v'] = 'vsplit',   -- open up item in new vertical split
            ['ctrl-x'] = 'split',    -- open up item in new horizontal split
            ['ctrl-c'] = 'closeall', -- close quickfix window and abort fzf
        }
    }
})
require('nvim-autopairs').setup {}
require('nvim-ts-autotag').setup()
require('colorizer').setup()
require('nvim-surround').setup({})
require('hlslens').setup()
require('scrollbar').setup({
    handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true, -- requires gitsigns
        handle = true,
        search = true,   -- requires hlslens
        ale = false,     -- requires ALE
    },
})
require('ufo').setup({
    provider_selector = function(_, _, _)
        return { 'treesitter', 'indent' }
    end
})
-- After nvim-ts-context-commentstring installation
require('nvim-treesitter.configs').setup {
    -- Install the parsers for the languages you want to comment in
    -- Here are the supported languages:
    ensure_installed = {
        'astro', 'css', 'glimmer', 'graphql', 'html', 'javascript',
        'lua', 'nix', 'php', 'python', 'scss', 'svelte', 'tsx', 'twig',
        'typescript', 'vim', 'vue',
    },
}
-- context_commentstring is deprecated
-- require('ts_context_commentstring').setup {}
-- vim.g.skip_ts_context_commentstring_module = true

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

local dap = require('dap')
dap.adapters.chrome = {
    type = "executable",
    command = "node",
    -- args = { os.getenv("HOME") .. "/path/to/vscode-chrome-debug/out/src/chromeDebug.js" } -- TODO adjust
    args = { os.getenv("HOME") .. "/.config/nvim/vscode-chrome-debug/out/src/chromeDebug.js" } -- TODO adjust
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}

dap.configurations.typescriptreact = { -- change to typescript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}

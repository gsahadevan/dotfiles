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
local signs = { Error = '', Hint = '', Info = '', Warn = '' }
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
-- keymap('n', '<leader>pv', vim.cmd.Explore, { desc = 'Open Netrw directory listing' })
keymap('n', '<leader>pv', '<cmd>:Oil<cr>', { desc = 'Open oil directory listing' })
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
-- │ Install lazy                      │
-- ╰───────────────────────────────────╯

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out,                            'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- ╭───────────────────────────────────╮
-- │ Install packages                  │
-- ╰───────────────────────────────────╯

-- Setup lazy.nvim
require('lazy').setup({
    spec = {
        -- packer can manage itself
        { 'wbthomason/packer.nvim' },
        -- smart and powerful commenting plugin for neovim
        { 'numToStr/Comment.nvim' },
        -- sets commentstring option based on the cursor location, checked via treesitter queries
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        -- tiny plugin to enhance neovim 0.10.0 native comments
        { 'folke/ts-comments.nvim' },
        -- a file explorer for nvim written in lua
        {
            'nvim-tree/nvim-tree.lua',
            dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }
        },
        {
            'stevearc/oil.nvim',
            dependencies = { 'echasnovski/mini.icons' },
        },
        -- adds indentation guides to all lines (including empty lines), using nvim's virtual text feature
        { 'lukas-reineke/indent-blankline.nvim' },
        -- primary colorscheme catppuccin
        -- priority = 1000 -> to load it before all the other start plugins
        {
            { 'catppuccin/nvim',             name = 'catppuccin',   lazy = false, priority = 1000 },
            { 'arzg/vim-colors-xcode',       name = 'xcode',        lazy = false, priority = 1000 },
            { 'projekt0n/github-nvim-theme', name = 'github-theme', lazy = false, priority = 1000 },
            { 'folke/tokyonight.nvim',       name = 'tokyonight',   lazy = false, priority = 1000, opts = {} },
            { 'rose-pine/neovim',            name = 'rose-pine',    lazy = false, priority = 1000 },
        },
        -- statusline written in lua
        { 'nvim-lualine/lualine.nvim' },
        -- fuzzy finder for files
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.6',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        -- find emojis with telescope :Telescope symbols
        { 'nvim-telescope/telescope-symbols.nvim' },
        -- neovim core stuffs can fill telescope
        { 'nvim-telescope/telescope-ui-select.nvim' },
        -- change the sorting algorithm to fuzzy find files using telescope
        { 'nvim-telescope/telescope-frecency.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 },
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v2.x',
            dependencies = {
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
                {
                    'L3MON4D3/LuaSnip',
                    run = 'make install_jsregexp'
                },
                { 'rafamadriz/friendly-snippets' },
                { 'saadparwaiz1/cmp_luasnip' },
            }
        },
        { 'nvimdev/lspsaga.nvim' },
        -- git browse and blame
        { 'dinhhuy258/git.nvim' },
        -- show git file modification signs on gutter
        { 'lewis6991/gitsigns.nvim' },
        -- single tabpage interface for easily cycling through git diffs
        { 'sindrets/diffview.nvim' },
        -- visualize and resolve git conflicts
        {
            'akinsho/git-conflict.nvim',
            version = "*",
            config = true
        },
        -- seamlessly move btw nvim panes and tmux
        { 'christoomey/vim-tmux-navigator' },
        -- also required for nvim-ufo, nvim-ts-autotag
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            config = function()
                local config = require('nvim-treesitter.configs')
                config.setup({
                    auto_install = false,
                    ensure_installed = {
                        'bash',
                        'ruby',
                        'html',
                        'css',
                        'scss',
                        'javascript',
                        'typescript',
                        'json',
                        'lua',
                    },
                    highlight = { enable = true },
                    indent = { enable = false },
                })
            end
        },
        -- powerful autopair plugin that supports multiple characters
        { 'windwp/nvim-autopairs' },
        -- use treesitter to autoclose and autorename html tag
        { 'windwp/nvim-ts-autotag' },
        -- surround selections, in style
        { 'kylechui/nvim-surround' },
        -- general purpose command line fuzzy finder
        {
            'junegunn/fzf',
            run = function()
                vim.fn['fzf#install']()
            end
        },
        -- high performance color highlighter
        { 'norcalli/nvim-colorizer.lua' },
        -- make neovim's quickfix window better
        { 'kevinhwang91/nvim-bqf' },
        -- extensible neovim scrollbar
        {
            'petertriho/nvim-scrollbar',
            dependencies = { 'kevinhwang91/nvim-hlslens' }
        },
        -- makes nvim's fold look modern and keep high performance
        {
            'kevinhwang91/nvim-ufo',
            dependencies = { 'kevinhwang91/promise-async' }
        },
        -- neovim plugin for GitHub copilot
        { 'github/copilot.vim' },
        -- neovim plugin for GitHub copilot chat
        {
            'CopilotC-Nvim/CopilotChat.nvim',
            dependencies = {
                { 'github/copilot.vim' },
                { 'nvim-lua/plenary.nvim', branch = 'master' },
            },
            build = 'make tiktoken',
            opts = {},
        },
        {
            'MeanderingProgrammer/render-markdown.nvim',
            dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
            -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
            -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
            ---@module 'render-markdown'
            ---@type render.md.UserConfig
            opts = {},
        },
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        install = { colorscheme = { 'habamax' } },
        -- automatically check for plugin updates
        checker = { enabled = true },
    }
})

-- ╭───────────────────────────────────╮
-- │ Add autocommands                  │
-- ╰───────────────────────────────────╯

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
            error = '',
            hint = '',
            info = '',
            warning = '',
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
-- helper function to parse output
local function parse_output(proc)
    local result = proc:wait()
    local ret = {}
    if result.code == 0 then
        for line in vim.gsplit(result.stdout, '\n', { plain = true, trimempty = true }) do
            -- Remove trailing slash
            line = line:gsub('/$', '')
            ret[line] = true
        end
    end
    return ret
end

-- build git status cache
local function new_git_status()
    return setmetatable({}, {
        __index = function(self, key)
            local ignore_proc = vim.system(
                { 'git', 'ls-files', '--ignored', '--exclude-standard', '--others', '--directory' },
                {
                    cwd = key,
                    text = true,
                }
            )
            local tracked_proc = vim.system({ 'git', 'ls-tree', 'HEAD', '--name-only' }, {
                cwd = key,
                text = true,
            })
            local ret = {
                ignored = parse_output(ignore_proc),
                tracked = parse_output(tracked_proc),
            }

            rawset(self, key, ret)
            return ret
        end,
    })
end
local git_status = new_git_status()

-- Clear git status cache on refresh
local refresh = require('oil.actions').refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
    git_status = new_git_status()
    orig_refresh(...)
end

-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require('oil').get_current_dir(bufnr)
    if dir then
        return vim.fn.fnamemodify(dir, ':~')
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

-- Configure oil
local detail = false
require('oil').setup({
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
    default_file_explorer = true,
    -- Id is automatically added at the beginning, and name at the end
    -- See :help oil-columns
    columns = {
        'icon',
        -- 'permissions',
        -- 'size',
        -- 'mtime',
    },
    -- Buffer-local options to use for oil buffers
    buf_options = {
        buflisted = false,
        bufhidden = 'hide',
    },
    -- Window-local options to use for oil buffers
    win_options = {
        wrap = false,
        signcolumn = 'no',
        cursorcolumn = false,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = 'nvic',
        winbar = '%!v:lua.get_oil_winbar()',
    },
    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = false,
    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    skip_confirm_for_simple_edits = false,
    -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
    -- (:help prompt_save_on_select_new_entry)
    prompt_save_on_select_new_entry = true,
    -- Oil will automatically delete hidden buffers after this delay
    -- You can set the delay to false to disable cleanup entirely
    -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
        -- Enable or disable LSP file operations
        enabled = true,
        -- Time to wait for LSP file operations to complete before skipping
        timeout_ms = 1000,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to 'unmodified' to only save unmodified buffers
        autosave_changes = false,
    },
    -- Constrain the cursor to the editable parts of the oil buffer
    -- Set to `false` to disable, or 'name' to keep it on the file names
    constrain_cursor = 'editable',
    -- Set to true to watch the filesystem for changes and reload oil
    watch_for_changes = false,
    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = '', mode = 'n' })
    -- Additionally, if it is a string that matches 'actions.<name>',
    -- it will use the mapping at require('oil.actions').<name>
    -- Set to `false` to remove a keymap
    -- See :help oil-actions for a list of all available actions
    keymaps = {
        ['g?'] = { 'actions.show_help', mode = 'n' },
        ['<CR>'] = 'actions.select',
        ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
        ['<C-t>'] = { 'actions.select', opts = { tab = true } },
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = { 'actions.close', mode = 'n' },
        ['<C-l>'] = 'actions.refresh',
        ['-'] = { 'actions.parent', mode = 'n' },
        ['_'] = { 'actions.open_cwd', mode = 'n' },
        ['`'] = { 'actions.cd', mode = 'n' },
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
        ['gs'] = { 'actions.change_sort', mode = 'n' },
        ['gx'] = 'actions.open_external',
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
        ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
        ['gd'] = {
            desc = 'Toggle file detail view',
            callback = function()
                detail = not detail
                if detail then
                    require('oil').set_columns({ 'icon', 'permissions', 'size', 'mtime' })
                else
                    require('oil').set_columns({ 'icon' })
                end
            end,
        },
    },
    -- Set to false to disable all of the above keymaps
    use_default_keymaps = true,
    -- view_options = {
    --     -- Show files and directories that start with '.'
    --     show_hidden = false,
    --     -- This function defines what is considered a 'hidden' file
    --     is_hidden_file = function(name, bufnr)
    --         local m = name:match('^%.')
    --         return m ~= nil
    --     end,
    --     -- This function defines what will never be shown, even when `show_hidden` is set
    --     is_always_hidden = function(name, bufnr)
    --         return false
    --     end,
    --     -- Sort file names with numbers in a more intuitive order for humans.
    --     -- Can be 'fast', true, or false. 'fast' will turn it off for large directories.
    --     natural_order = 'fast',
    --     -- Sort file and directory names case insensitive
    --     case_insensitive = false,
    --     sort = {
    --         -- sort order can be 'asc' or 'desc'
    --         -- see :help oil-columns to see which columns are sortable
    --         { 'type', 'asc' },
    --         { 'name', 'asc' },
    --     },
    --     -- Customize the highlight group for the file name
    --     highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
    --         return nil
    --     end,
    -- },
    view_options = {
        is_hidden_file = function(name, bufnr)
            local dir = require('oil').get_current_dir(bufnr)
            local is_dotfile = vim.startswith(name, '.') and name ~= '..'
            -- if no local directory (e.g. for ssh connections), just hide dotfiles
            if not dir then
                return is_dotfile
            end
            -- dotfiles are considered hidden unless tracked
            if is_dotfile then
                return not git_status[dir].tracked[name]
            else
                -- Check if file is gitignored
                return git_status[dir].ignored[name]
            end
        end,
    },
    -- Extra arguments to pass to SCP when moving/copying files over SSH
    extra_scp_args = {},
    -- EXPERIMENTAL support for performing file operations with git
    git = {
        -- Return true to automatically git add/mv/rm files
        add = function(path)
            return false
        end,
        mv = function(src_path, dest_path)
            return false
        end,
        rm = function(path)
            return false
        end,
    },
    -- Configuration for the floating window in oil.open_float
    float = {
        -- Padding around the floating window
        padding = 2,
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0,
        max_height = 0,
        border = 'rounded',
        win_options = {
            winblend = 0,
        },
        -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
        get_win_title = nil,
        -- preview_split: Split direction: 'auto', 'left', 'right', 'above', 'below'.
        preview_split = 'auto',
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
            return conf
        end,
    },
    -- Configuration for the file preview window
    preview_win = {
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
        -- How to open the preview window 'load'|'scratch'|'fast_scratch'
        preview_method = 'fast_scratch',
        -- A function that returns true to disable preview on a file e.g. to avoid lag
        disable_preview = function(filename)
            return false
        end,
        -- Window-local options to use for preview window buffers
        win_options = {},
    },
    -- Configuration for the floating action confirmation window
    confirmation = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.8} means 'the lesser of 100 columns or 80% of total'
        max_width = 0.9,
        -- min_width = {40, 0.4} means 'the greater of 40 columns or 40% of total'
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        -- max_height = {80, 0.9} means 'the lesser of 80 columns or 90% of total'
        max_height = 0.9,
        -- min_height = {5, 0.1} means 'the greater of 5 columns or 10% of total'
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = 'rounded',
        win_options = {
            winblend = 0,
        },
    },
    -- Configuration for the floating progress window
    progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = 'rounded',
        minimized_border = 'none',
        win_options = {
            winblend = 0,
        },
    },
    -- Configuration for the floating SSH window
    ssh = {
        border = 'rounded',
    },
    -- Configuration for the floating keymaps help window
    keymaps_help = {
        border = 'rounded',
    },
})
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
        keywords = { 'bold' },
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
                    hint  = ' ',
                    info  = ' ',
                    warn  = ' ',
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
    lightbulb = {
        enable = false,
        sign = true,
        debounce = 10,
        sign_priority = 40,
        virtual_text = true,
        enable_in_insert = true,
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
        add          = { text = '┃' },
        change       = { text = '┃' }, -- │, ▎
        delete       = { text = '' }, -- , _, ,
        topdelete    = { text = '' }, -- , ‾,
        changedelete = { text = '' }, -- ~, ≈
        untracked    = { text = '┆' },
    },



    sign_priority = 1,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
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
-- Configure git-conflict
require('git-conflict').setup({
    -- default_mappings = {
    --     ours = 'o', -- co choose ours
    --     theirs = 't', -- ct choose theirs
    --     none = '0', -- c0 choose none
    --     both = 'b', -- cb choose both
    --     next = 'n', -- [x move to next conflict
    --     prev = 'n', -- ]x move to prev conflict
    -- },
    default_mappings = true,     -- disable buffer local mapping created by this plugin
    default_commands = true,     -- disable commands created by this plugin
    disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
    list_opener = 'copen',       -- command or function to open the conflicts list
    highlights = {               -- They must have background color, otherwise the default color will be used
        incoming = 'DiffAdd',
        current = 'DiffText',
    }
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
local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

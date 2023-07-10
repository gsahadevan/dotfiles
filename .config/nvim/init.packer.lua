-- add base settings
vim.cmd('autocmd!')

vim.wo.number          = true
vim.wo.relativenumber  = true

vim.opt.wrap           = false -- do not wrap lines, display one long line
vim.opt.linebreak      = false -- if wrap is enabled, set to true | donot split words

vim.scriptencoding     = 'utf-8'
vim.opt.encoding       = 'utf-8'
vim.opt.fileencoding   = 'utf-8'

vim.opt.title          = true

vim.opt.tabstop        = 4
vim.opt.softtabstop    = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true
vim.opt.smarttab       = true

vim.g.indentLine_char  = '┃' -- indentLine

vim.opt.autoindent     = true
vim.opt.smartindent    = true
vim.opt.breakindent    = true

vim.opt.hlsearch       = true
vim.opt.incsearch      = true
vim.opt.ignorecase     = true -- case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase      = true

vim.opt.showcmd        = true
vim.opt.cmdheight      = 1
vim.opt.laststatus     = 2
vim.opt.inccommand     = 'split'
vim.opt.signcolumn     = 'yes:3'            -- always shows the sign column, otherwise it would shift the text each time
vim.opt.backspace      = { 'start', 'eol', 'indent' }
vim.opt.completeopt    = 'menuone,noselect' -- set completeopt to have a better completion experience
vim.opt.clipboard      = 'unnamed'

vim.opt.backupskip     = { '/tmp/*', '/private/tmp/*' }
vim.opt.backup         = false
vim.opt.swapfile       = false -- disable swap files in neovim
vim.opt.undofile       = true  -- save undo history
vim.opt.updatetime     = 250   -- decrease update time

vim.opt.foldcolumn     = '2'   -- show foldcolumn in nvim 0.9
vim.opt.foldlevel      = 99    -- set high fold level for nvim-ufo
vim.opt.foldlevelstart = 99    -- start with all code unfolded
vim.opt.foldenable     = true  -- enable fold for nvim-ufo

vim.opt.cursorline     = true
vim.opt.termguicolors  = true
vim.opt.winblend       = 10
vim.opt.wildoptions    = 'pum'
vim.opt.pumblend       = 0
vim.opt.pumheight      = 15 -- completion height, adds scrollbar
vim.opt.pumwidth       = 50 -- completion width
vim.opt.background     = 'dark'

-- vim.opt.winbar         = '%f'        -- shows the absolute file path on winbar

vim.opt.path:append { '**' }         -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.formatoptions:append { 'r' } -- Add asterisks in block comments

-- turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
    pattern = '*',
    command = 'set nopaste'
})

-- [[ Highlight on yank ]]
-- see `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = highlight_group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- diagnostic symbols in the sign column (gutter)
local signs = { Error = ' ', Hint = ' ', Info = ' ', Warn = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.opt.rtp:append('/opt/homebrew/opt/fzf')

-- add keymaps

-- Modes reference
-- n - normal_mode | i - insert_mode | v - visual_mode | x - visual_block_mode | t - term_mode (terminal) | c - command_mode

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set -- Shorten function name

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('n', '<leader>a', 'gg<S-v>G', { noremap = true, silent = true, desc = 'Select all text in buffer' })
keymap('n', '<leader>nh', ':nohl<CR>', { noremap = true, silent = true, desc = 'No (Remove) search highlighting' })

-- Split window
keymap('n', 'sv', ':vsplit<Return><C-w>w', { noremap = true, silent = true, desc = 'Window split current vertically' })
keymap('n', 'ss', ':split<Return><C-w>w', { noremap = true, silent = true, desc = 'Window split current horizontally' })
keymap('n', 'se', '<C-w>=', { noremap = true, silent = true, desc = 'Window make all equal size' })
keymap('n', 'sw', ':close<CR>', { noremap = true, silent = true, desc = 'Window close current' })

-- Stay in visual mode while indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move visually selected text up and down
keymap('v', 'J', ':m \'>+1<cr>gv=gv', opts) -- in normal mode J -> joins lines
keymap('v', 'K', ':m \'<-2<cr>gv=gv', opts) -- in normal mode K -> LSP show hover doc

-- some other options are :topleft split | terminal or :vsplit | terminal or :split | resize 20 | term
keymap('n', '<leader>tt', ':belowright split | resize 15 | terminal<cr>', { desc = 'Open terminal window' })

keymap('n', 'J', 'mzJ`z')         -- keeps cursor in place when joining lines
keymap('n', '<C-d>', '<C-d>zz')   -- keeps cursor in the middle of screen
keymap('n', '<C-u>', '<C-u>zz')   -- keeps cursor in the middle of screen
keymap('n', 'n', 'nzzzv')         -- keeps cursor in the middle for search terms
keymap('n', 'N', 'Nzzzv')         -- keeps cursor in the middle for search terms
keymap('x', '<leader>pp', '"_dp') -- preserve pasted in buffer
keymap('n', 'x', '"_x')           -- do not save characters cut using x

-- pressing leaderY would enable further yanking to save yanked text to clipboard
keymap('n', '<leader>y', '"+y')
keymap('v', '<leader>y', '"+y')
keymap('n', '<leader>Y', '"+Y')

keymap('n', '<leader>d', '"_d')
keymap('v', '<leader>d', '"_d')

keymap('n', ',f', '<cmd>%s/"/\'/g<cr>', { desc = 'Format replace " with \'' })
keymap('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Buffer next' })
keymap('n', '<s-tab>', '<cmd>bprevious<cr>', { desc = 'Buffer prev' })
keymap('n', '<leader>w', '<cmd>bdelete<cr>', { desc = 'Buffer close' })
keymap('n', '<leader>W', '<cmd>bdelete!<cr>', { desc = 'Buffer force close' })

-- install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

-- install packages
require('packer').startup({
    function(use)
        use { 'wbthomason/packer.nvim' }                                                -- packer can manage itself
        use { 'numToStr/Comment.nvim' }                                                 -- smart and powerful commenting plugin for neovim
        use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } } -- a file explorer for nvim written in lua
        use { 'lukas-reineke/indent-blankline.nvim' }                                   -- adds indentation guides to all lines (including empty lines), using nvim's virtual text feature
        use { 'lalitmee/cobalt2.nvim', requires = { 'tjdevries/colorbuddy.nvim' } }     -- colorscheme
        use { 'nvim-lualine/lualine.nvim' }                                             -- statusline written in lua

        use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
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
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'L3MON4D3/LuaSnip' },
                { 'saadparwaiz1/cmp_luasnip' }
            }
        }

        use { 'dinhhuy258/git.nvim' }                                      -- git browse and blame
        use { 'lewis6991/gitsigns.nvim' }                                  -- show git file modification signs on gutter
        use { 'rhysd/git-messenger.vim' }                                  -- show commit history under cursor in a pop window
        use { 'sindrets/diffview.nvim' }                                   -- single tabpage interface for easily cycling through git diffs
        use { 'NeogitOrg/neogit', requires = { 'nvim-lua/plenary.nvim' } } -- magit clone for nvim

        use { 'christoomey/vim-tmux-navigator' }                           -- seamlessly move btw vim panes and tmux

        use { 'folke/trouble.nvim', requires = { 'nvim-tree/nvim-web-devicons' } }
        use { 'kevinhwang91/nvim-bqf' }
        use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
        use { 'nvim-treesitter/nvim-treesitter' }

        use { 'windwp/nvim-autopairs' }
        use { 'windwp/nvim-ts-autotag' }
        use { 'norcalli/nvim-colorizer.lua' }
        use { 'kylechui/nvim-surround' }
        use { 'petertriho/nvim-scrollbar', requires = { 'kevinhwang91/nvim-hlslens' } }
        use { 'kevinhwang91/nvim-ufo', requires = { 'kevinhwang91/promise-async' } } -- makes nvim's fold look modern and keep high performance

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

-- when we are bootstrapping a configuration, it doesn't make sense to execute the rest of the init.lua.
-- restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed   '
    print '    Wait until Packer completes,  '
    print '       then restart nvim          '
    print '=================================='
    return
end

-- automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})

-- configure plugins
require('Comment').setup()
require('nvim-tree').setup()
keymap('n', '<leader>b', '<cmd>NvimTreeToggle<cr>', { desc = 'NvimTree toggle' })
require('indent_blankline').setup {
    char = '┊',
    show_trailing_blankline_indent = false,
}
require('colorbuddy').colorscheme('cobalt2')
vim.api.nvim_command('colorscheme cobalt2')
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'papercolor_light',
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = { 'packer', 'NvimTree', 'mason' },
        globalstatus = true,
    },
    winbar = {
        lualine_c = {
            { 'filename', path = 3, color = { bg = 'NONE' } }
        },
    },
    inactive_winbar = {
        lualine_c = {
            { 'filename', path = 3, color = { bg = 'NONE' } }
        },
    },
    sections = {
        lualine_c = {},
    },
    inactive_sections = {
        lualine_c = {},
    },
    tabline = {
        lualine_c = {
            {
                'buffers',
                mode = 2,
                max_length = vim.o.columns * 2 / 3,
                filetype_names = {
                    TelescopePrompt = 'Telescope',
                    dashboard = 'Dashboard',
                    packer = 'Packer',
                    fzf = 'FZF',
                    alpha = 'Alpha',
                    NvimTree = 'Explorer',
                },
                use_mode_colors = false,
                buffers_color = {
                    active = { fg = 'black', bg = 'white' },
                    inactive = {},
                },
            },
        },
        lualine_b = {},
        lualine_a = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
}

require('telescope').setup {
    defaults = {
        prompt_prefix = '❯ ',
        layout_config = {
            height = 0.95,
            width = 0.95,
        },
    },
}
pcall(require('telescope').load_extension, 'fzf')
local _, telescope = pcall(require, 'telescope')
if telescope then
    local builtin = require('telescope.builtin')
    local themes = require('telescope.themes')

    -- intention is to pass options to the existing pickers
    -- ref: https://github.com/nvim-telescope/telescope.nvim/issues/848
    local options = themes.get_dropdown {
        path_display = { 'absolute' },
        winblend = 10,
        previewer = false,
        layout_config = {
            height = 0.95,
            width = 0.95,
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

    -- See `:help telescope.builtin`
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    keymap('n', '<leader>/', buffer_fuzzy_find, { desc = 'Telescope fuzzy search in curr. buffer' })
    keymap('n', '<leader>?', builtin.oldfiles, { desc = 'Telescope find recently opened files' })
    keymap('n', '<leader><space>', find_open_buffers, { desc = 'Telescope show existing buffers' })

    keymap('n', '<leader>f<cr>', builtin.resume, { desc = 'Telescope find, resume previous search' })
    keymap('n', '<leader>fp', builtin.find_files, { desc = 'Telescope find files with preview' })
    keymap('n', '<leader>fP', find_files_all, { desc = 'Telescope find files with preview incl. hidden' })
    keymap('n', '<leader>ff', find_files_wo_preview, { desc = 'Telescope find files without preview' })

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
    keymap('n', '<leader>tsc', builtin.commands, { desc = 'Telescope show plugin commands' })
    keymap('n', '<leader>tsC', builtin.command_history, { desc = 'Telescope show command history' })
    keymap('n', '<leader>tsd', builtin.diagnostics, { desc = 'Telescope show diagnostics' })
    keymap('n', '<leader>tsh', builtin.help_tags, { desc = 'Telescope show help tags' })
    keymap('n', '<leader>tsj', builtin.jumplist, { desc = 'Telescope show jump list' })
    keymap('n', '<leader>tsk', builtin.keymaps, { desc = 'Telescope show keymaps' })
    keymap('n', '<leader>tsm', builtin.man_pages, { desc = 'Telescope show man pages' })
    keymap('n', '<leader>tsr', builtin.registers, { desc = 'Telescope show registers' })
    keymap('n', '<leader>ts;', builtin.marks, { desc = 'Telescope show marks' })
    -- lsp
    keymap('n', '<leader>vd', show_lsp_definition_in_split, { desc = 'Telescope LSP go to definition in vsplit' })
    keymap('n', '<leader>tld', builtin.lsp_definitions, { desc = 'Telescope LSP show definitions' })
    keymap('n', '<leader>tli', builtin.lsp_implementations, { desc = 'Telescope LSP show implementations' })
    keymap('n', '<leader>tlr', builtin.lsp_references, { desc = 'Telescope LSP show references' })
    keymap('n', '<leader>tls', builtin.lsp_document_symbols, { desc = 'Telescope LSP show document symbols' })
    keymap('n', '<leader>tlw', builtin.lsp_workspace_symbols, { desc = 'Telescope LSP show workspace symbols' })
end

local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false -- read here for more understanding - https://github.com/VonHeikemen/lsp-zero.nvim#keybindings
    })
end)
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls()) -- (optional) configure lua language server for neovim
lsp.setup()
-- list of commands and keymaps
-- K:       vim.lsp.buf.hover()             Displays hover information about the symbol under the cursor in a floating window.
-- gd:      vim.lsp.buf.definition()        Jumps to the definition of the symbol under the cursor.
-- gD:      vim.lsp.buf.declaration()       Jumps to the declaration of the symbol under the cursor. Some servers don't implement this feature.
-- gi:      vim.lsp.buf.implementation()    Lists all the implementations for the symbol under the cursor in the quickfix window.
-- go:      vim.lsp.buf.type_definition()   Jumps to the definition of the type of the symbol under the cursor.
-- gr:      vim.lsp.buf.references()        Lists all the references to the symbol under the cursor in the quickfix window.
-- gs:      vim.lsp.buf.signature_help()    Displays signature information about the symbol under the cursor in a floating window. If a mapping already exists for this key this function is not bound.
-- <F2>:    vim.lsp.buf.rename()            Renames all references to the symbol under the cursor.
-- <F3>:    vim.lsp.buf.format()            Format code in current buffer.
-- <F4>:    vim.lsp.buf.code_action()       Selects a code action available at the current cursor position.
-- gl:      vim.diagnostic.open_float()     Show diagnostics in a floating window.
-- [d:      vim.diagnostic.goto_prev()      Move to the previous diagnostic in the current buffer.
-- ]d:      vim.diagnostic.goto_next()      Move to the next diagnostic.

-- add new keymaps since in mac it is hard to use function rows
keymap({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature info for symbol under cursor' })
keymap('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Renames all references to symbol under cursor' })
keymap('n', '<leader>cf', vim.lsp.buf.format, { desc = 'Format code in current buffer' })
keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Show code action available for cursor pos' })
keymap('n', '<leader>cq', vim.diagnostic.setloclist, { desc = 'Open diagnostic set loc list' })

require('mason').setup({
    ui = {
        border = 'rounded',
        height = 0.95,
        width = 0.95,
    }
})

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
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
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
    yadm = {
        enable = false
    },
})
local _, gitsigns = pcall(require, 'gitsigns')
if gitsigns then
    keymap('n', '<leader>]h', gitsigns.next_hunk, { desc = 'Git hunk next' })
    keymap('n', '<leader>[h', gitsigns.prev_hunk, { desc = 'Git hunk prev' })
    keymap('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Git hunk preview' })
    keymap('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git hunk stage' })
    keymap('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Git hunk unstage' })
    keymap('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git hunk reset' })
end
local _, git_messenger = pcall(require, 'git-messenger')
if git_messenger then
    keymap('n', '<leader>gmo', '<cmd>GitMessenger<cr>', { desc = 'Git messenger open' })
    keymap('n', '<leader>gmc', '<cmd>GitMessengerClose<cr>', { desc = 'Git messenger close' })
end
require('diffview').setup({})
require('neogit').setup {}

local _, trouble = pcall(require, 'trouble')
if trouble then
    keymap('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { desc = 'Trouble toggle' })
    keymap('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>',
        { desc = 'Trouble show workspace diagnostics' })
    keymap('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>',
        { desc = 'Trouble show document diagnostics' })
    keymap('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { desc = 'Trouble show window location list' })
    keymap('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { desc = 'Trouble show quickfix list' })
    keymap('n', '<leader>xr', '<cmd>TroubleToggle lsp_references<cr>',
        { desc = 'Trouble show references under word cursor' })
    keymap('n', '<leader>xD', '<cmd>TroubleToggle lsp_definitions<cr>',
        { desc = 'Trouble show definitions under word cursor' })
    keymap('n', '<leader>xT', '<cmd>TroubleToggle lsp_type_definitions<cr>',
        { desc = 'Trouble show type definitions under word cursor' })
end
require('bqf').setup({})

require('nvim-autopairs').setup {}
require('nvim-ts-autotag').setup()
require('colorizer').setup()
require('nvim-surround').setup({})
require('scrollbar').setup({})
require('scrollbar.handlers.gitsigns').setup()
require('scrollbar.handlers.search').setup({})
require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
    end
})

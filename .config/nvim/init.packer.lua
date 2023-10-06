-- ╭───────────────────────────────────╮
-- │ Add basic options and settings    │
-- ╰───────────────────────────────────╯

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

vim.g.indentLine_char  = '┊' -- indentLine '┃'

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

vim.opt.foldcolumn     = '1'   -- show foldcolumn in nvim 0.9
vim.opt.foldlevel      = 99    -- set high fold level for nvim-ufo
vim.opt.foldlevelstart = 99    -- start with all code unfolded
vim.opt.foldenable     = true  -- enable fold for nvim-ufo

vim.opt.wildoptions    = 'pum'
vim.opt.pumblend       = 0
vim.opt.pumheight      = 15 -- completion height, adds scrollbar
vim.opt.pumwidth       = 50 -- completion width

vim.opt.cursorline     = true
vim.opt.termguicolors  = true
vim.opt.background     = 'dark'
-- vim.opt.winblend       = 10
-- vim.opt.winbar         = '%f'        -- shows the absolute file path on winbar

vim.opt.splitright     = true
vim.opt.splitbelow     = true

vim.opt.path:append { '**' }         -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.formatoptions:append { 'r' } -- Add asterisks in block comments
vim.opt.rtp:append('/opt/homebrew/opt/fzf')

-- Add diagnostic symbols in the sign column (gutter)
local signs = { Error = '', Hint = '', Info = '', Warn = '' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

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

keymap('n', '<leader>a', 'gg<S-v>G', { noremap = true, silent = true, desc = 'Select all text in buffer' })
keymap('n', '<esc>', ':nohl<CR>', { noremap = true, silent = true, desc = 'No (Remove) search highlighting' })

-- Split window
keymap('n', 'sv', ':vsplit<Return><C-w>w', { noremap = true, silent = true, desc = 'Window split current vertically' })
keymap('n', 'ss', ':split<Return><C-w>w', { noremap = true, silent = true, desc = 'Window split current horizontally' })
keymap('n', 'se', '<C-w>=', { noremap = true, silent = true, desc = 'Window make all equal size' })
keymap('n', 'sw', ':close<CR>', { noremap = true, silent = true, desc = 'Window close current' })
keymap('n', 'sr', '<C-w><C-r>', { noremap = true, silent = true, desc = 'Window swap position' })

-- Stay in visual mode while indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move visually selected text up and down
keymap('v', 'J', ':m \'>+1<cr>gv=gv', opts) -- in normal mode J -> joins lines
keymap('v', 'K', ':m \'<-2<cr>gv=gv', opts) -- in normal mode K -> LSP show hover doc

-- Some other options are :topleft split | terminal or :vsplit | terminal or :split | resize 20 | term
keymap('n', '<leader>tt', ':belowright split | resize 15 | terminal<cr>', { desc = 'Open terminal window' })

keymap('n', 'J', 'mzJ`z')         -- keeps cursor in place when joining lines
keymap('n', '<C-d>', '<C-d>zz')   -- keeps cursor in the middle of screen
keymap('n', '<C-u>', '<C-u>zz')   -- keeps cursor in the middle of screen
keymap('n', 'n', 'nzzzv')         -- keeps cursor in the middle for search terms
keymap('n', 'N', 'Nzzzv')         -- keeps cursor in the middle for search terms
keymap('x', '<leader>pp', '"_dp') -- preserve pasted in buffer
keymap('n', 'x', '"_x')           -- do not save characters cut using x

-- Pressing leaderY would enable further yanking to save yanked text to clipboard
keymap('n', '<leader>y', '"+y')
keymap('v', '<leader>y', '"+y')
keymap('n', '<leader>Y', '"+Y')

keymap('n', '<leader>d', '"_d')
keymap('v', '<leader>d', '"_d')

keymap('n', ',f', '<cmd>%s/"/\'/g<cr>', { desc = 'Format replace " with \'' })

-- Specific to this configuration
keymap('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Buffer next' })
keymap('n', '<s-tab>', '<cmd>bprevious<cr>', { desc = 'Buffer prev' })
keymap('n', '<leader>w', '<cmd>bdelete<cr> <bar> <cmd>bprevious<cr>', { desc = 'Buffer close' })
keymap('n', '<leader>q', '<cmd>%bdelete<cr> <bar> <cmd>edit#<cr>', { desc = 'Buffer close others' }) -- alternatively :%bd|e#
keymap('n', '<leader>W', '<cmd>bdelete!<cr> <bar> <cmd>bprevious<cr>', { desc = 'Buffer force close' })

-- Specific to command line
keymap('c', 'Q', 'q')   -- replace Q with q on the command mode
keymap('c', 'Qa', 'qa') -- replace Qa with qa on the command mode

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
        use { 'wbthomason/packer.nvim' }                                                -- packer can manage itself
        use { 'numToStr/Comment.nvim' }                                                 -- smart and powerful commenting plugin for neovim
        use { 'JoosepAlviste/nvim-ts-context-commentstring' }                           -- sets commentstring option based on the cursor location, checked via treesitter queries
        use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } } -- a file explorer for nvim written in lua
        use { 'lukas-reineke/indent-blankline.nvim' }                                   -- adds indentation guides to all lines (including empty lines), using nvim's virtual text feature
        use { 'lalitmee/cobalt2.nvim', requires = { 'tjdevries/colorbuddy.nvim' } }     -- primary colorscheme
        -- use { 'catppuccin/nvim', as = 'catppuccin' }                                    -- secondary colorscheme
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
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'hrsh7th/cmp-cmdline' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'L3MON4D3/LuaSnip' },
                { 'saadparwaiz1/cmp_luasnip' }
            }
        }

        use { 'nvimdev/lspsaga.nvim' }

        use { 'dinhhuy258/git.nvim' }                                                   -- git browse and blame
        use { 'lewis6991/gitsigns.nvim' }                                               -- show git file modification signs on gutter
        use { 'sindrets/diffview.nvim' }                                                -- single tabpage interface for easily cycling through git diffs
        use { 'NeogitOrg/neogit', requires = { 'nvim-lua/plenary.nvim' } }              -- magit clone for nvim

        use { 'christoomey/vim-tmux-navigator' }                                        -- seamlessly move btw vim panes and tmux

        use { 'kevinhwang91/nvim-bqf' }                                                 -- make neovim's quickfix window better
        use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }            -- general purpose command line fuzzy finder
        use { 'nvim-treesitter/nvim-treesitter' }                                       -- also required for nvim-ufo, nvim-ts-autotag

        use { 'windwp/nvim-autopairs' }                                                 -- powerful autopair plugin that supports multiple characters
        use { 'windwp/nvim-ts-autotag' }                                                -- use treesitter to autoclose and autorename html tag
        use { 'norcalli/nvim-colorizer.lua' }                                           -- high performance color highlighter
        use { 'kylechui/nvim-surround' }                                                -- surround selections, in style

        use { 'petertriho/nvim-scrollbar', requires = { 'kevinhwang91/nvim-hlslens' } } -- extensible neovim scrollbar
        use { 'kevinhwang91/nvim-ufo', requires = { 'kevinhwang91/promise-async' } }    -- makes nvim's fold look modern and keep high performance

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

-- ╭───────────────────────────────────╮
-- │ Configure packages                │
-- ╰───────────────────────────────────╯
-- Configure comment
require('Comment').setup {
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
-- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
-- Contains the complete configuration list is for nvim-tree
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
-- Configure cobalt2 colorscheme
require('colorbuddy').colorscheme('cobalt2')
vim.api.nvim_command('colorscheme cobalt2')
-- Configure catppuccin colorscheme | secondary colorscheme
-- vim.api.nvim_command('colorscheme catppuccin-frappe') -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

-- Configure lualine
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'papercolor_light',
        -- theme = 'catppuccin', -- secondary colorscheme
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = {
            statusline = { 'packer', 'NvimTree', 'mason' },
            winbar = { 'packer', 'NvimTree', 'mason' },
        },
        globalstatus = true,
    },
    -- Using Lspsaga from now on
    -- winbar = {
    --     lualine_c = {
    --         { 'filename', path = 3, color = { bg = 'NONE' } }
    --     },
    -- },
    -- inactive_winbar = {
    --     lualine_c = {
    --         { 'filename', path = 3, color = { bg = 'NONE' } }
    --     },
    -- },
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
                    -- active = { fg = 'black', bg = '#ef9f76' }, -- secondary colorscheme
                    inactive = {},
                },
            },
        },
    }
}
-- Configure telescope + add keymaps
require('telescope').setup {
    defaults = {
        prompt_prefix = '❯ ',
        layout_config = {
            height = 0.95,
            width = 0.95,
        },
        mappings = {
            n = {
                ['<c-w>'] = require('telescope.actions').delete_buffer,
            },
            i = {
                ['<c-w>'] = require('telescope.actions').delete_buffer,
            },
        },
    },
}
pcall('fzf', require('telescope').load_extension)
local _, telescope = pcall(require, 'telescope')
if telescope then
    local builtin = require('telescope.builtin')
    local themes = require('telescope.themes')

    -- intention is to pass options to the existing pickers
    -- ref: https://github.com/nvim-telescope/telescope.nvim/issues/848
    local options = themes.get_dropdown {
        path_display = { 'absolute' },
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
    keymap('n', '<leader>tsd', builtin.diagnostics, { desc = 'Telescope show diagnostics' })
    keymap('n', '<leader>tsr', builtin.registers, { desc = 'Telescope show registers' })
    keymap('n', '<leader>tsm', builtin.marks, { desc = 'Telescope show marks' })
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
lsp.on_attach(function(client, bufnr)
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
keymap('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { nowait = true, noremap = true, silent = true, desc = 'Show hover info of symbol under cursor' })
keymap('n', 'gh', '<cmd>Lspsaga finder tyd+ref+imp+def<cr>', { noremap = true, silent = true, desc = 'Show LSP finder' })
keymap('n', '<leader>o', '<cmd>Lspsaga outline<cr>', { noremap = true, silent = true, desc = 'Open sysmbols outline' })
keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', { noremap = true, silent = true, desc = 'Show code action available for cursor pos' }) -- changed from <f4>
-- Lspsaga call heirarchy
keymap('n', '<leader>ci', '<cmd>Lspsaga incoming_calls<cr>', { noremap = true, silent = true, desc = 'Show incoming call heirarchy' })
keymap('n', '<leader>co', '<cmd>Lspsaga outgoing_calls<cr>', { noremap = true, silent = true, desc = 'Show outgoing call heirarchy' })
-- Lspsaga definitions
keymap('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', { nowait = true, noremap = true, silent = true })
keymap('n', 'gD', '<cmd>Lspsaga peek_definition<cr>', { nowait = true, noremap = true, silent = true, desc = 'Lspsaga peek definition' })
keymap('n', 'gt', '<cmd>Lspsaga goto_type_definition<cr>', { nowait = true, noremap = true, silent = true, desc = 'Lspsaga goto type definition' })
keymap('n', 'gT', '<cmd>Lspsaga peek_type_definition<cr>', { nowait = true, noremap = true, silent = true, desc = 'Lspsaga peek type definition' })
-- Lspsaga diagnostics
keymap('n', 'sl', '<cmd>Lspsaga show_line_diagnostics<cr>', { noremap = true, silent = true, desc = 'Show line diagnostics' })
keymap('n', 'sc', '<cmd>Lspsaga show_cursor_diagnostics<cr>', { noremap = true, silent = true, desc = 'Show cursor diagnostics' })
keymap('n', 'sb', '<cmd>Lspsaga show_buf_diagnostics<cr>', { noremap = true, silent = true, desc = 'Show buffer diagnostics' })
keymap('n', 'g]', '<cmd>Lspsaga diagnostic_jump_prev<cr>', { noremap = true, silent = true, desc = 'Move to the prev diagnostic in current buffer' })
keymap('n', 'g[', '<cmd>Lspsaga diagnostic_jump_next<cr>', { noremap = true, silent = true, desc = 'Move to the next diagnostic in current buffer' })
-- Lspsaga misc
keymap('n', '<leader>cr', '<cmd>Lspsaga rename<cr>', { noremap = true, silent = true, desc = 'Renames all references of symbol under cursor' })
keymap('n', '<leader>cf', vim.lsp.buf.format, { noremap = true, silent = true, desc = 'Format code in current buffer' })
keymap('n', '<leader>cq', vim.diagnostic.setloclist, { noremap = true, silent = true, desc = 'Open diagnostic set loc list' })
-- Configure completion
-- You need to setup `cmp` after lsp-zero
local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 30
local MIN_LABEL_WIDTH = 30
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
require('luasnip.loaders.from_vscode').lazy_load()
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
        { name = 'luasnip', keyword_length = 2 },
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
        max_width = 50,
    },
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
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

            -- add icons along with item kind
            vim_item.kind = string.format('%s', vim_item.kind)
            vim_item.menu = ({
                nvim_lsp = '_lsp ',
                nvim_lua = '_lua ',
                luasnip  = 'snip ',
                buffer   = 'bufr ',
                path     = 'path ',
            })[entry.source.name]

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
    yadm = {
        enable = false
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
require('diffview').setup({})
require('neogit').setup {}
-- Need to configure nvim-bqf with additional values
-- require('bqf').setup({})
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
-- require('scrollbar.handlers.gitsigns').setup()
-- require('scrollbar.handlers.search').setup({})
require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
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
    context_commentstring = {
        enable = true,
    },
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

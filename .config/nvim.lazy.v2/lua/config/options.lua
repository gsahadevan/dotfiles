-- ╭───────────────────────────────────╮
-- │ Add basic options and settings    │
-- ╰───────────────────────────────────╯

-- lazy Cannot make changes, 'modifiable' is off
-- vim.cmd('autocmd!') -- clear all autocmds
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
-- vim.scriptencoding     = 'utf-8' -- the encoding used for the script
-- vim.opt.encoding       = 'utf-8' -- the encoding displayed
-- vim.opt.fileencoding   = 'utf-8' -- the encoding written to file

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

vim.cmd('autocmd!')

vim.wo.number          = true
vim.wo.relativenumber  = true

vim.opt.wrap           = false              -- do not wrap lines, display one long line
vim.opt.linebreak      = false              -- if wrap is enabled, set to true | donot split words

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
vim.opt.winblend       = 0
vim.opt.wildoptions    = 'pum'
vim.opt.pumblend       = 0
vim.opt.pumheight      = 15 -- completion height, adds scrollbar
vim.opt.pumwidth       = 50 -- completion width
vim.opt.background     = 'dark'

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


vim.opt.rtp:append('/opt/homebrew/opt/fzf')

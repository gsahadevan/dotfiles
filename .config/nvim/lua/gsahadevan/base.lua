vim.cmd('autocmd!')

vim.wo.number          = true
vim.wo.relativenumber  = true

vim.scriptencoding     = 'utf-8'
vim.opt.encoding       = 'utf-8'
vim.opt.fileencoding   = 'utf-8'

vim.g.indentLine_char  = '┃' -- indentLine

vim.opt.tabstop        = 4
vim.opt.softtabstop    = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true
vim.opt.smarttab       = true

vim.opt.title          = true
vim.opt.autoindent     = true
vim.opt.smartindent    = true
vim.opt.breakindent    = true

vim.opt.hlsearch       = true
vim.opt.incsearch      = true
vim.opt.ignorecase     = true -- Case insensitive searching UNLESS /C or capital in search

vim.opt.backup         = false
vim.opt.showcmd        = true
vim.opt.cmdheight      = 1
vim.opt.laststatus     = 2
vim.opt.backupskip     = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand     = 'split'
vim.opt.signcolumn     = 'yes:3'            -- always shows the sign column, otherwise it would shift the text each time
vim.opt.wrap           = false              -- do not wrap lines, display one long line
vim.opt.linebreak      = false              -- if wrap is enabled, set to true | donot split words
vim.opt.backspace      = { 'start', 'eol', 'indent' }
vim.opt.completeopt    = 'menuone,noselect' -- set completeopt to have a better completion experience
vim.opt.clipboard      = 'unnamed'

vim.opt.foldcolumn     = '2'         -- show foldcolumn in nvim 0.9
vim.opt.foldlevel      = 99          -- set high fold level for nvim-ufo
vim.opt.foldlevelstart = 99          -- start with all code unfolded
vim.opt.foldenable     = true        -- enable fold for nvim-ufo

vim.opt.path:append { '**' }         -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }
vim.opt.formatoptions:append { 'r' } -- Add asterisks in block comments

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "set nopaste"
})

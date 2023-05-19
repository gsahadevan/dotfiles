return {
    { 'moll/vim-bbye' }, -- required for closing last buffer :BDelete
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update({ with_sync = true }))
        end,
    },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'nvim-treesitter/playground' },
    { 'dinhhuy258/git.nvim' }, -- for git blame & browse
    { 'rhysd/git-messenger.vim' }, -- shows history of commits under cursor in a pop window
    { 'kevinhwang91/nvim-hlslens' },
    { 'petertriho/nvim-scrollbar' },
    { 'williamboman/mason.nvim' }, -- automatically install and manage LSP servers, instead of manually installing them
    { 'williamboman/mason-lspconfig.nvim' }, -- closes gaps between mason and lspconfig
    { 'neovim/nvim-lspconfig' }, -- configurations for neovim LSP
    { 'williamboman/mason.nvim' }, -- automatically install and manage LSP servers, instead of manually installing them
    { 'williamboman/mason-lspconfig.nvim' }, -- closes gaps between mason and lspconfig
    { 'neovim/nvim-lspconfig' }, -- configurations for neovim LSP
    { 'jose-elias-alvarez/null-ls.nvim' }, -- use neovim as language server to inject LSP diagnostics, code actions, and more via lua
    { 'glepnir/lspsaga.nvim' },
}

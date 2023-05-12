return {
    { 'gsahadevan/onedark.nvim' },
    { 'nvim-telescope/telescope.nvim',             dependencies = { 'nvim-lua/plenary.nvim' } }, -- fuzzy finder
    { 'nvim-telescope/telescope-file-browser.nvim' },                                            -- kind of a replacement for :Lex
    -- { 'noib3/nvim-cokeline', dependencies = 'kyazdani42/nvim-web-devicons' }, -- buffer line
    -- { 'noib3/nvim-cokeline',                       dependencies = 'nvim-tree/nvim-web-devicons' }, -- buffer line
    -- { 'moll/vim-bbye' },                                                                           -- required for closing last buffer :BDelete
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update({ with_sync = true }))
        end,
    },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'nvim-treesitter/playground' },
    { 'lewis6991/gitsigns.nvim' }, -- shows git changes next to the numbers (hunks)
    { 'dinhhuy258/git.nvim' },     -- for git blame & browse
    { 'rhysd/git-messenger.vim' }, -- shows history of commits under cursor in a pop window
    { 'kevinhwang91/nvim-hlslens' },
    { 'petertriho/nvim-scrollbar' },
    { 'williamboman/mason.nvim' },           -- automatically install and manage LSP servers, instead of manually installing them
    { 'williamboman/mason-lspconfig.nvim' }, -- closes gaps between mason and lspconfig
    { 'neovim/nvim-lspconfig' },             -- configurations for neovim LSP
    { 'williamboman/mason.nvim' },           -- automatically install and manage LSP servers, instead of manually installing them
    { 'williamboman/mason-lspconfig.nvim' }, -- closes gaps between mason and lspconfig
    { 'neovim/nvim-lspconfig' },             -- configurations for neovim LSP
    { 'hrsh7th/cmp-buffer' },                -- completion source for buffer words
    { 'hrsh7th/cmp-nvim-lua' },              -- completion source for lua
    { 'hrsh7th/cmp-path' },                  -- completion source for path
    { 'hrsh7th/cmp-cmdline' },               -- completion source for path
    { 'L3MON4D3/LuaSnip' },                  -- snippet engine | needed for completion
    { 'saadparwaiz1/cmp_luasnip' },
    { 'rafamadriz/friendly-snippets' },
    { 'hrsh7th/nvim-cmp' },                -- autocompletion plugin
    { 'hrsh7th/cmp-nvim-lsp' },            -- LSP source for nvim-cmp
    { 'onsails/lspkind-nvim' },            -- vscode-like pictograms | not required anymore
    { 'jose-elias-alvarez/null-ls.nvim' }, -- use neovim as language server to inject LSP diagnostics, code actions, and more via lua
    { 'MunifTanjim/prettier.nvim' },       -- prettier plugin for neovim's built-in LSP client
    { 'glepnir/lspsaga.nvim' },            --
    { 'folke/which-key.nvim' },
    { 'folke/trouble.nvim' },              -- a pretty list for showing diagnostics, references, telescope results, quickfix and location lists
    { 'windwp/nvim-autopairs' },
    { 'windwp/nvim-ts-autotag' },
    { 'norcalli/nvim-colorizer.lua' }, -- shows colors on hex codes
}

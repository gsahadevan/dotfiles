--------------------------------------------------------------------------------
-- this PDE (Personalized Development Environment) consists of
-- 1. LSP
-- 2. Auto completion
-- 3. Treesitter
-- 4. GIT support
-- 5. Fuzzy Finder
--------------------------------------------------------------------------------
local status, packer = pcall(require, 'packer')
if not status then
    print('packer is not installed')
    return
end

-- vim.cmd [[packadd packer.nvim]]

-- make packer use popup window
packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end,
    },
})

packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    --------------------------------------------------------------------------------
    -- cosmetics
    --------------------------------------------------------------------------------
    use 'folke/tokyonight.nvim' -- colorschemes | setup is available on highlights.lua
    use { 'svrana/neosolarized.nvim', requires = { 'tjdevries/colorbuddy.nvim' } }
    -- use 'olimorris/onedarkpro.nvim' -- could also use this as an alternative
    use 'nvim-lualine/lualine.nvim' -- statusline
    use { 'noib3/nvim-cokeline', requires = 'kyazdani42/nvim-web-devicons' } -- buffer line
    use 'moll/vim-bbye'

    --------------------------------------------------------------------------------
    -- LSP
    --------------------------------------------------------------------------------
    use 'neovim/nvim-lspconfig' -- languager-server-protocol
    use 'onsails/lspkind-nvim' -- vscode-like pictograms
    use 'glepnir/lspsaga.nvim' -- some UI enhancements for LSP | offer fns like definitions, quick actions etc
    use 'williamboman/mason.nvim' -- for managing other lsp servers like tailwindcss helpers
    use 'williamboman/mason-lspconfig.nvim'
    use 'jose-elias-alvarez/null-ls.nvim' -- use neovim as language server to inject LSP diagnostics, code actions, and more via lua
    use 'MunifTanjim/prettier.nvim' -- prettier plugin for neovim's built-in LSP client
    use 'j-hui/fidget.nvim' -- shows useful status updates for LSP

    --------------------------------------------------------------------------------
    -- auto completion
    --------------------------------------------------------------------------------
    use 'hrsh7th/cmp-buffer' -- completion source for buffer words
    use 'hrsh7th/cmp-nvim-lsp' -- completion source for neovim's built-in LSP
    use 'hrsh7th/cmp-nvim-lua' -- completion source for lua
    use 'hrsh7th/cmp-path' -- completion source for path
    use 'hrsh7th/nvim-cmp' -- completion
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip' -- snippet engine | needed for completion

    --------------------------------------------------------------------------------
    -- treesitter
    --------------------------------------------------------------------------------
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects', -- additional text objects via treesitter
        after = 'nvim-treesitter'
    }

    --------------------------------------------------------------------------------
    -- fuzzy finder
    --------------------------------------------------------------------------------
    use 'nvim-lua/plenary.nvim' -- common utilities
    use 'nvim-telescope/telescope.nvim' -- fuzzy finder
    -- use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
    -- Fuzzy Finder algorithm which requires local dependencies to be built, load only if `make` is available
    -- use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

    --------------------------------------------------------------------------------
    -- file browser
    --------------------------------------------------------------------------------
    use 'nvim-telescope/telescope-file-browser.nvim' -- kind of a replacement for :Lex
    use 'kyazdani42/nvim-web-devicons' -- file icons for supported plugins like telescope, lualine etc
    use 'kyazdani42/nvim-tree.lua' -- replacement for :Lex (netrw)

    --------------------------------------------------------------------------------
    -- git
    --------------------------------------------------------------------------------
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'lewis6991/gitsigns.nvim' -- shows git changes next to the numbers (hunks)
    use 'dinhhuy258/git.nvim' -- for git blame & browse

    --------------------------------------------------------------------------------
    -- misc. ide features
    --------------------------------------------------------------------------------
    use 'petertriho/nvim-scrollbar'
    use 'kevinhwang91/nvim-hlslens'
    use 'rafamadriz/friendly-snippets' -- snippets as suggestions on completion | use along with LuaSnip
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'numToStr/Comment.nvim' -- 'gc' for commenting visual regions/lines
    use 'lukas-reineke/indent-blankline.nvim' -- adds indentation guides to all lines (including empty lines)
    -- use 'tpope/vim-sleuth' -- detect tabstop and shiftwidth automatically
    use 'norcalli/nvim-colorizer.lua' -- shows colors on hex codes
    use({
        'kylechui/nvim-surround',
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    --------------------------------------------------------------------------------
    -- inspired from emacs | shows available keys
    --------------------------------------------------------------------------------
    use {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    --------------------------------------------------------------------------------
    -- Better Buffers
    --------------------------------------------------------------------------------
    -- use { 'akinsho/bufferline.nvim', tag = 'v3.*', requires = 'nvim-tree/nvim-web-devicons' } -- make buffers look and act like vscode tabs
    -- use 'moll/vim-bbye' -- gives Bdelete | read more about Bdelete vs bdelete
    -- use({
    --     'noib3/nvim-cokeline',
    --     requires = 'kyazdani42/nvim-web-devicons', -- If you want devicons
    --     config = function()
    --         require('cokeline').setup()
    --     end
    -- })

    -- un-used plugins from craftzdog
    -- use({
    --  'iamcco/markdown-preview.nvim',
    --  run = function() vim.fn['mkdp#util#install']() end,
    --})
    -- use 'folke/zen-mode.nvim'
    -- use 'github/copilot.vim'
end)

--------------------------------------------------------------------------------
-- Inspirations
--------------------------------------------------------------------------------
-- https://github.com/craftzdog/dotfiles-public
-- https://dev.to/craftzdog/my-neovim-setup-for-react-typescript-tailwind-css-etc-58fb
-- https://www.youtube.com/watch?v=ajmK0ZNcM4Q
--
-- https://www.youtube.com/@devonduty
--
-- neovim as ide from scratch
-- https://github.com/LunarVim/Neovim-from-scratch
-- https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ
--
-- https://github.com/NeuralNine/config-files/blob/master/init.vim
-- https://www.youtube.com/watch?v=JWReY93Vl6g

--------------------------------------------------------------------------------
-- required brew installations
--------------------------------------------------------------------------------
-- brew install neovim
-- brew install wget
-- brew install ripgrep
-- brew install lua-language-server
-- brew install tree-sitter
-- brew install rg
-- brew install prettierd
-- brew install prettier

--------------------------------------------------------------------------------
-- required npm installations
--------------------------------------------------------------------------------
-- npm install -g neovim
-- npm install -g prettier
-- npm install -g typescript-language-server typescript
-- npm install -g @fsouza/prettierd
-- npm install -D prettier

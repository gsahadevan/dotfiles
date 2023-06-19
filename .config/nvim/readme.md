### TODO

- https://github.com/simrat39/symbols-outline.nvim --> keymaps pending
- https://github.com/AckslD/nvim-neoclip.lua
- https://github.com/nvim-pack/nvim-spectre
- https://github.com/SmiteshP/nvim-navbuddy
- https://github.com/kevinhwang91/nvim-bqf#installation
- https://github.com/luukvbaal/statuscol.nvim
- https://github.com/jose-elias-alvarez/typescript.nvim
- https://github.com/phaazon/hop.nvim
- TimUntersberger/neogit
- rhysd/vim-grammarous
- sheerun/vim-polyglot
- Markdown preview
- use 'ellisonleao/glow.nvim'
- install without yarn or npm
- use({ 
-   "iamcco/markdown-preview.nvim",
-   run = function() vim.fn["mkdp#util#install"]() end,
-  })
- Nvim motions
-  use {
-    'phaazon/hop.nvim',
-     branch = 'v2',
-     requires = { 'nvim-lua/plenary.nvim' },
-   config = function()
-      require 'hop'.setup { keys = 'etovxpqdgfblzhckisuran' }
-    end
-  }
- add to nvim-lspconfig
`
{
    -- renders diagnostics using virtual lines on top of the real line of code
    'Maan2003/lsp_lines.nvim',
    config = function()
        require('lsp_lines').setup()
        vim.diagnostic.config({ virtual_lines = true })
        vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
    end
},
`

#### Plugins for full stack dev
-  use 'pangloss/vim-javascript' --JS support
-  use 'leafgarland/typescript-vim' --TS support
-  use 'maxmellon/vim-jsx-pretty' --JS and JSX syntax
-  use 'jparise/vim-graphql' --GraphQL syntax
-  use 'mattn/emmet-vim'

#### Few additional installations 

- python3 -m pip install --user --upgrade pynvim
- brew install wget
- npm install -g neovim

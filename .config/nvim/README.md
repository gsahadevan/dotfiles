### TODO

- https://github.com/simrat39/symbols-outline.nvim --> keymaps pending
- https://github.com/AckslD/nvim-neoclip.lua
- https://github.com/nvim-pack/nvim-spectre
- https://github.com/SmiteshP/nvim-navbuddy
- https://github.com/kevinhwang91/nvim-bqf#installation
- https://github.com/luukvbaal/statuscol.nvim
- https://github.com/jose-elias-alvarez/typescript.nvim
- https://github.com/phaazon/hop.nvim
- https://github.com/sidebar-nvim/sidebar.nvim/ -> did try, didn't like the current state.
- https://github.com/b0o/incline.nvim -> Incline is a plugin for creating lightweight floating statuslines
- TimUntersberger/neogit
- rhysd/vim-grammarous
- sheerun/vim-polyglot
- Markdown preview
- use 'ellisonleao/glow.nvim'
- `kdheepak/lazygit.nvim` git pull/stash/stage/commit/push/log. lazygit TUI is quite popular and could be used also outside of Vim.
- `rhysd/conflict-marker.vim` conflicts resolution, similar to VS Code/Atom style which put the conflict markers inline with the editor instead of another, 3-way window. intuitive and easy to use.
- `f-person/git-blame.nvim` git blame, and the GitBlameOpenCommitURL command is really handy since it will open the commit in your hosted Git origin/service like GitLab/GitHub, you could then view the diff or you could send the link to your colleague during code reviews or discussion
- `airblade/vim-gitgutter` git diff markers in the gutter, handy also when navigating/cycling your changes across multiple buffers since the hunks are treated as changelist
- `NeogitOrg/neogit` git interface for Neovim, inspired by Magit.

install without yarn or npm
```
use({ 
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
})
```

nvim motions
```
use {
    'phaazon/hop.nvim',
    branch = 'v2',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require 'hop'.setup { keys = 'etovxpqdgfblzhckisuran' }
    end
}
```

add to nvim-lspconfig
```
{
    -- renders diagnostics using virtual lines on top of the real line of code
    'Maan2003/lsp_lines.nvim',
    config = function()
        require('lsp_lines').setup()
        vim.diagnostic.config({ virtual_lines = true })
        vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
    end
},
```

could also use `bufferline` instead of `nvim-cokeline`
```
return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup {}
    end
}
```

#### Plugins for full stack dev
```
use 'pangloss/vim-javascript'     -- JS support
use 'leafgarland/typescript-vim'  -- TS support
use 'maxmellon/vim-jsx-pretty'    -- JS and JSX syntax
use 'jparise/vim-graphql'         -- GraphQL syntax
use 'mattn/emmet-vim'
```

#### Few additional installations
```
python3 -m pip install --user --upgrade pynvim
brew install wget
npm install -g neovim
```

### How to use `nvim-surround`
```
     Old text                    Command         New text
--------------------------------------------------------------------------------
     surr*ound_words             ysiw)           (surround_words)
     *make strings               ys$"            "make strings"
     [delete ar*ound me!]        ds]             delete around me!
     remove <b>HTML t*ags</b>    dst             remove HTML tags
     'change quot*es'            cs'"            "change quotes"
     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
     delete(functi*on calls)     dsf             function calls
```

### How to use `diffview` merge_tool
```
diffview gives some default keymaps on the merge_tool
:DiffviewOpen to open the mege_tool during merge or rebase to list the conflicted files
The default mapping `g<C-x>` allows you to cycle through the available layouts

You can jump between conflict markers with `]x` and `[x`

Further, in addition to the normal |copy-diffs| mappings you can use 
`2do` to obtain the hunk from the OURS side of the diff,
    `3do` to obtain the hunk from the THEIRS side of the diff

    Additionally there are mappings for operating directly on the conflict markers:
    • `<leader>co`: Choose the OURS version of the conflict.
    • `<leader>ct`: Choose the THEIRS version of the conflict.
    • `<leader>cb`: Choose the BASE version of the conflict.
    • `<leader>ca`: Choose all versions of the conflict (effectively
            just deletes the markers, leaving all the content).
    • `dx`: Choose none of the versions of the conflict (delete the
            conflict region).
```

### Few awesome colorschemes
```
    { 'catppuccin/nvim',              name = 'catppuccin',  priority = 1000 },
    { 'arzg/vim-colors-xcode',        name = 'xcode' },
    { 'Mofiqul/dracula.nvim',         name = 'dracula' },
    { 'projekt0n/github-nvim-theme',  name = 'github-theme' },
    { 'Yazeed1s/minimal.nvim' },
    { 'lunarvim/horizon.nvim' },
    { 'rebelot/kanagawa.nvim' },
    { 'Shatur/neovim-ayu' },
    { 'frenzyexists/aquarium-vim' },
    { 'folke/tokyonight.nvim',        lazy = false,         priority = 1000, opts = {} },
    { 'bluz71/vim-nightfly-colors',   name = 'nightfly',    lazy = false,    priority = 1000 },
    { 'bluz71/vim-moonfly-colors',    name = 'moonfly',     lazy = false,    priority = 1000 },
    { 'rose-pine/neovim',             name = 'rose-pine' },
    { 'AlexvZyl/nordic.nvim',         lazy = false,         priority = 1000, },
    { 'dgox16/oldworld.nvim',         lazy = false,         priority = 1000 },
    { 'comfysage/evergarden',         lazy = false,         priority = 1000 },
    { 'EdenEast/nightfox.nvim' },
    { 'scottmckendry/cyberdream.nvim' },
    { 'savq/melange-nvim' },
    { 'rmehri01/onenord.nvim' },
    { 'vague2k/vague.nvim' },
    { 'sainnhe/everforest' },
    { 'sainnhe/sonokai' },
    { 'sainnhe/gruvbox-material' },
    { 'sainnhe/edge' },
    { 'sainnhe/everforest' },
    { 'sainnhe/gruvbox-material' },
    { 'sainnhe/sonokai' },
    { 'sainnhe/edge' },
    { 'sainnhe/everforest' },
    { 'sainnhe/gruvbox-material' },
    { 'sainnhe/sonokai' },
    {
         'ribru17/bamboo.nvim',
         lazy = false,
         priority = 1000,
         config = function()
             require('bamboo').setup {
                 -- optional configuration here
             }
             require('bamboo').load()
         end,
    },
    {
         'craftzdog/solarized-osaka.nvim',
         lazy = false,
         priority = 1000,
         opts = {},
    }
```


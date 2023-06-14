-- Normal Mode
--
-- `gcc` - Toggles the current line using linewise comment
-- `gbc` - Toggles the current line using blockwise comment
-- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
-- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
-- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
-- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
--
-- `gco` - Insert comment to the next line and enters INSERT mode
-- `gcO` - Insert comment to the previous line and enters INSERT mode
-- `gcA` - Insert comment to end of the current line and enters INSERT mode

-- Visual Mode
--
-- `gc` - Toggles the region using linewise comment
-- `gb` - Toggles the region using blockwise comment

-- Examples
-- # Linewise
--
-- `gcw` - Toggle from the current cursor position to the next word
-- `gc$` - Toggle from the current cursor position to the end of line
-- `gc}` - Toggle until the next blank line
-- `gc5j` - Toggle 5 lines after the current cursor position
-- `gc8k` - Toggle 8 lines before the current cursor position
-- `gcip` - Toggle inside of paragraph
-- `gca}` - Toggle around curly brackets

-- # Blockwise
--
-- `gb2}` - Toggle until the 2 next blank line
-- `gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
-- `gbac` - Toggle comment around a class (w/ LSP/treesitter support)

local _, cokeline = pcall(require, 'cokeline')
if cokeline then
    vim.api.nvim_set_keymap('n', '<s-tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
    vim.api.nvim_set_keymap('n', '<tab>', '<Plug>(cokeline-focus-next)', { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>p', '<Plug>(cokeline-switch-prev)', { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>n', '<Plug>(cokeline-switch-next)', { silent = true })
end

local _, vim_bbye = pcall(require, 'vim-bbye')
if vim_bbye then
    vim.api.nvim_set_keymap('n', '<leader>w', ':Bdelete<cr>', { noremap = true, silent = true })
end

local _, telescope = pcall(require, 'telescope')
if telescope then
    local builtin = require('telescope.builtin')
    local themes = require('telescope.themes')

    telescope.load_extension('file_browser')
    local show_fb = function()
        telescope.extensions.file_browser.file_browser({
            path = '%:p:h',
            -- cwd = telescope_buffer_dir(),
            cwd = vim.fn.expand('%:p:h'),
            respect_gitignore = true,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = 'insert', -- can be normal
            layout_config = { height = 20 }
        })
    end

    -- Intention is to pass options to the existing pickers
    -- Ref: https://github.com/nvim-telescope/telescope.nvim/issues/848
    local opts = themes.get_dropdown {
        path_display = { 'absolute' },
        winblend = 10,
        previewer = false,
        layout_config = {
            height = 0.9,
            width = 0.8,
        },
    }

    local buffer_fuzzy_find = function()
        builtin.current_buffer_fuzzy_find(opts)
    end

    local find_files_all = function()
        builtin.find_files {
            hidden = true,
            no_ignore = true
        }
    end

    local find_files_wo_preview = function()
        builtin.find_files(opts)
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

    local find_color_schemes = function()
        builtin.colorscheme { enable_preview = true }
    end

    -- See `:help telescope.builtin`
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    vim.keymap.set('n', '<leader>/', buffer_fuzzy_find, { desc = 'Telescope fuzzy search in curr. buffer' })
    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = 'Telescope find recently opened files' })
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = 'Telescope show existing buffers' })

    vim.keymap.set('n', '<leader>f<cr>', builtin.resume, { desc = 'Telescope find, resume previous search' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fF', find_files_all, { desc = 'Telescope find files incl. hidden' })
    vim.keymap.set('n', '<leader>fp', find_files_wo_preview, { desc = 'Telescope find files without preview' })

    vim.keymap.set('n', '<leader>sb', show_fb, { desc = 'Telescope show file browser' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Telescope list diagnostics' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope search using live grep' })
    vim.keymap.set('n', '<leader>sG', grep_search_all, { desc = 'Telescope search using live grep incl. hidden' })
    vim.keymap.set('n', '<leader>fG', grep_search_args, { desc = 'Telescope search using live grep incl. args' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Telescope search for word under cursor' })
    -- git
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope list git branches' })
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Telescope list git commits' })
    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope list git files' })
    -- vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope list git status' })
    -- misc
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope find keymaps' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope find help tags' })
    vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope find man pages' })
    vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Telescope find registers' })
    vim.keymap.set('n', '<leader>f;', builtin.marks, { desc = 'Telescope find marks' })
    vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Telescope list plugin commands' })
    vim.keymap.set('n', '<leader>fC', builtin.command_history, { desc = 'Telescope list command history' })
    vim.keymap.set('n', '<leader>ft', find_color_schemes, { desc = 'Telescope find and preview themes' })
    -- lsp
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'Telescope LSP show document symbols' })
    vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = 'Telescope LSP show workspace symbols' })
    vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'Telescope LSP show definitions' })
    vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = 'Telescope LSP show implementations' })
    vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'Telescope LSP show references' })
    --    if is_available 'nvim-notify' then
    --        maps.n['<leader>fn'] =
    --        { function() require('telescope').extensions.notify.notify() end, desc = 'Find notifications' }
    --    end

    vim.keymap.set('n', '<leader>vd', '<cmd>lua require("telescope.builtin").lsp_definitions({jump_type="vsplit"})<cr>',
        { desc = 'Telescope LSP go to definition in vsplit' })
    --    maps.n['<leader>ls'] = {
    --        function()
    --            local aerial_avail, _ = pcall(require, 'aerial')
    --            if aerial_avail then
    --                require('telescope').extensions.aerial.aerial()
    --            else
    --                require('telescope.builtin').lsp_document_symbols()
    --            end
    --        end,
    --        desc = 'Search symbols',
    --    }
end

local _, git = pcall(require, 'Git')
if git then
    vim.keymap.set('n', '<leader>gdo', '<cmd>GitDiff<CR>', { desc = 'Git diff open' })
    vim.keymap.set('n', '<leader>gdc', '<cmd>GitDiffClose<CR>', { desc = 'Git diff close' })
end

local _, gitsigns = pcall(require, 'gitsigns')
if gitsigns then
    -- git diff gives better options to open and close
    -- use <leader>gdo and <leader>gdc instead, refer Git section for more details
    -- vim.keymap.set('n', '<leader>gd', function() require('gitsigns').diffthis() end, { desc = 'Git diff' })
    --
    -- not using this option, git-messenger gives better config
    -- vim.keymap.set('n', '<leader>gl', function() require('gitsigns').blame_line() end, { desc = 'Git blame' })
    -- vim.keymap.set('n', '<leader>gL', function() require('gitsigns').blame_line { full = true } end,
    --     { desc = 'Git blame with details' })
    vim.keymap.set('n', '<leader>g]', function() require('gitsigns').next_hunk() end, { desc = 'Git next hunk' })
    vim.keymap.set('n', '<leader>g[', function() require('gitsigns').prev_hunk() end, { desc = 'Git prev hunk' })
    vim.keymap.set('n', '<leader>gp', function() require('gitsigns').preview_hunk() end, { desc = 'Git preview hunk' })
    vim.keymap.set('n', '<leader>gs', function() require('gitsigns').stage_hunk() end, { desc = 'Git stage hunk' })
    vim.keymap.set('n', '<leader>gu', function() require('gitsigns').undo_stage_hunk() end, { desc = 'Git unstage hunk' })
    vim.keymap.set('n', '<leader>gh', function() require('gitsigns').reset_hunk() end, { desc = 'Git reset hunk' })
    vim.keymap.set('n', '<leader>gS', function() require('gitsigns').stage_buffer() end, { desc = 'Git stage buffer' })
    vim.keymap.set('n', '<leader>gH', function() require('gitsigns').reset_buffer() end, { desc = 'Git reset buffer' })
end

-- TODO:decide whether to proceed and use this plugin or not
-- not going to use this new plugin, the same feature is available in gitsigns
-- use <leader>gl and <leader>gL
local _, git_messenger = pcall(require, 'git-messenger')
if git_messenger then
    vim.keymap.set('n', '<leader>gmo', '<cmd>GitMessenger<CR>', { desc = 'Git messenger open' })
    vim.keymap.set('n', '<leader>gmc', '<cmd>GitMessengerClose<CR>', { desc = 'Git messenger close' })
end

local _, trouble = pcall(require, 'trouble')
if trouble then
    vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { desc = 'Trouble toggle' })
    vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>',
        { desc = 'Trouble show workspace diagnostics' })
    vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>',
        { desc = 'Trouble show document diagnostics' })
    vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { desc = 'Trouble show window location list' })
    vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { desc = 'Trouble show quickfix list' })
    vim.keymap.set('n', '<leader>xr', '<cmd>TroubleToggle lsp_references<cr>',
        { desc = 'Trouble show references under word cursor' })
    vim.keymap.set('n', '<leader>xD', '<cmd>TroubleToggle lsp_definitions<cr>',
        { desc = 'Trouble show definitions under word cursor' })
    vim.keymap.set('n', '<leader>xT', '<cmd>TroubleToggle lsp_type_definitions<cr>',
        { desc = 'Trouble show type definitions under word cursor' })

    -- api you can use the following functions in your keybindings
    -- jump to the next item, skipping the groups
    -- require('trouble').next({ skip_groups = true, jump = true });

    -- jump to the previous item, skipping the groups
    -- require('trouble').previous({ skip_groups = true, jump = true });

    -- jump to the first item, skipping the groups
    -- require('trouble').first({ skip_groups = true, jump = true });

    -- jump to the last item, skipping the groups
    -- require('trouble').last({ skip_groups = true, jump = true });
end

local _, lspsaga = pcall(require, 'lspsaga')
if lspsaga then
    -- local opts = { noremap = true, silent = true }
    -- vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
    -- vim.keymap.set('n', '<c-k>', '<cmd>Lspsaga signature_help<CR>', opts)
    -- vim.keymap.set('n', '<c-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
    -- vim.keymap.set('n', 'gl', '<cmd>Lspsaga show_diagnostic<CR>', opts)
    -- vim.keymap.set('n', 'gd', '<cmd>Lspsaga lsp_finder<CR>', opts)
    -- vim.keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', opts)
    -- vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)
    --
    -- -- code action
    -- local codeaction = require('lspsaga.codeaction')
    -- vim.keymap.set('n', '<leader>ca', function() codeaction:code_action() end, { silent = true })
    -- vim.keymap.set('v', '<leader>ca', function()
    --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-U>', true, false, true))
    --     codeaction:range_code_action()
    -- end, { silent = true })

    -- LSP finder - Find the symbol's definition
    -- If there is no definition, it will instead be hidden
    -- When you use an action in finder like 'open vsplit',
    -- you can use <C-t> to jump back
    vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>')

    -- Code action
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>')

    -- Rename all occurrences of the hovered word for the entire file
    vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>')

    -- Rename all occurrences of the hovered word for the selected files
    vim.keymap.set('n', 'gR', '<cmd>Lspsaga rename ++project<CR>')

    -- Peek definition
    -- You can edit the file containing the definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to 'definition_action_keys'
    -- It also supports tagstack
    -- Use <C-t> to jump back
    vim.keymap.set('n', 'gD', '<cmd>Lspsaga peek_definition<CR>')

    -- Go to definition
    vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>')

    -- Peek type definition
    -- You can edit the file containing the type definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to 'definition_action_keys'
    -- It also supports tagstack
    -- Use <C-t> to jump back
    vim.keymap.set('n', 'gT', '<cmd>Lspsaga peek_type_definition<CR>')

    -- Go to type definition
    vim.keymap.set('n', 'gt', '<cmd>Lspsaga goto_type_definition<CR>')


    -- Show line diagnostics
    -- You can pass argument ++unfocus to
    -- unfocus the show_line_diagnostics floating window
    vim.keymap.set('n', '<leader>sl', '<cmd>Lspsaga show_line_diagnostics<CR>')

    -- Show cursor diagnostics
    -- Like show_line_diagnostics, it supports passing the ++unfocus argument
    vim.keymap.set('n', '<leader>sc', '<cmd>Lspsaga show_cursor_diagnostics<CR>')

    -- Show buffer diagnostics
    vim.keymap.set('n', '<leader>sb', '<cmd>Lspsaga show_buf_diagnostics<CR>')

    -- Diagnostic jump
    -- You can use <C-o> to jump back to your previous location
    vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
    vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>')

    -- Diagnostic jump with filters such as only jumping to an error
    vim.keymap.set('n', '[E', function()
        require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)
    vim.keymap.set('n', ']E', function()
        require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)

    -- Toggle outline
    vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>')

    -- Hover Doc
    -- If there is no hover doc,
    -- there will be a notification stating that
    -- there is no information available.
    -- To disable it just use ':Lspsaga hover_doc ++quiet'
    -- Pressing the key twice will enter the hover window
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>')

    -- If you want to keep the hover window in the top right hand corner,
    -- you can pass the ++keep argument
    -- Note that if you use hover with ++keep, pressing this key again will
    -- close the hover window. If you want to jump to the hover window
    -- you should use the wincmd command '<C-w>w'
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc ++keep<CR>')

    -- Call hierarchy
    vim.keymap.set('n', '<leader>ci', '<cmd>Lspsaga incoming_calls<CR>')
    vim.keymap.set('n', '<leader>co', '<cmd>Lspsaga outgoing_calls<CR>')

    -- Floating terminal
    vim.keymap.set({ 'n', 't' }, '<A-d>', '<cmd>Lspsaga term_toggle<CR>')
end

local _, todo_comments = pcall(require, 'todo-comments')
if todo_comments then
    vim.keymap.set('n', ']t', todo_comments.jump_next, { desc = 'Todo Comment - jump to next' })
    vim.keymap.set('n', '[t', todo_comments.jump_prev, { desc = 'Todo Comment - jump to prev' })
    -- You can also specify a list of valid jump keywords
    vim.keymap.set('n', ']t', function()
        require('todo-comments').jump_next({ keywords = { 'ERROR', 'WARNING' } })
    end, { desc = 'Todo Comment - jump to next error / warning' })
end

local _, aerial = pcall(require, 'aerial')
if aerial then
    -- You probably also want to set a keymap to toggle aerial
    vim.keymap.set('n', '<leader>ao', '<cmd>AerialToggle<CR>', { desc = 'Aerial toggle' })
    vim.keymap.set('n', '<leader>an', '<cmd>AerialNavToggle<CR>', { desc = 'Aerial toggle nav window' })
end

local _, symbols_outline = pcall(require, 'symbols-outline')
if symbols_outline then
    vim.keymap.set('n', '<leader>so', '<cmd>SymbolsOutline<CR>', { desc = 'Symbols outline toggle' })
end

local _, goto_preview = pcall(require, 'goto-preview')
if goto_preview then
    -- mappings are not possible due to conflicts
    -- vim.keymap.set('n', '<leader>gpd', 'goto_preview.goto_preview_definition', { desc = 'Go to preview definition' })
    -- vim.keymap.set('n', '<leader>gpt', 'goto_preview.goto_preview_type_definition',
    --     { desc = 'Go to preview type definition' })
    -- vim.keymap.set('n', '<leader>gpi', 'goto_preview.goto_preview_implementation',
    --     { desc = 'Go to preview implementation' })
    -- vim.keymap.set('n', '<leader>gP', 'goto_preview.close_all_win', { desc = 'Go to close all win' })
    -- vim.keymap.set('n', '<leader>gpr', 'goto_preview.goto_preview_references', { desc = 'Go to preview references' })
end

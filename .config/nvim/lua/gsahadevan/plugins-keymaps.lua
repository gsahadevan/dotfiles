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
    vim.api.nvim_set_keymap('n', '<s-tab>', '<Plug>(cokeline-focus-prev)',
        { silent = true, desc = 'Cokeline focus prev buffer' })
    vim.api.nvim_set_keymap('n', '<tab>', '<Plug>(cokeline-focus-next)',
        { silent = true, desc = 'Cokeline focus next buffer' })
    vim.api.nvim_set_keymap('n', '<leader>p', '<Plug>(cokeline-switch-prev)',
        { silent = true, desc = 'Cokeline move current buffer backward' })
    vim.api.nvim_set_keymap('n', '<leader>n', '<Plug>(cokeline-switch-next)',
        { silent = true, desc = 'Cokeline move current buffer forward' })
end

local _, vim_bbye = pcall(require, 'vim-bbye')
if vim_bbye then
    vim.api.nvim_set_keymap('n', '<leader>w', ':Bdelete<cr>',
        { noremap = true, silent = true, desc = 'Close current buffer' })
    vim.api.nvim_set_keymap('n', '<leader>W', ':Bdelete!<cr>',
        { noremap = true, silent = true, desc = 'Close current buffer without warning' })
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
    vim.keymap.set('n', '<leader>fp', builtin.find_files, { desc = 'Telescope find files with preview' })
    vim.keymap.set('n', '<leader>fP', find_files_all, { desc = 'Telescope find files with preview incl. hidden' })
    vim.keymap.set('n', '<leader>ff', find_files_wo_preview, { desc = 'Telescope find files without preview' })
    vim.keymap.set('n', '<leader>ft', find_color_schemes, { desc = 'Telescope find and preview themes' })

    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope search using live grep' })
    vim.keymap.set('n', '<leader>sG', grep_search_all, { desc = 'Telescope search using live grep incl. hidden' })
    vim.keymap.set('n', '<leader>fG', grep_search_args, { desc = 'Telescope search using live grep incl. args' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Telescope search for word under cursor' })
    -- git
    vim.keymap.set('n', '<leader>tgb', builtin.git_branches, { desc = 'Telescope list git branches' })
    vim.keymap.set('n', '<leader>tgc', builtin.git_commits, { desc = 'Telescope list git commits' })
    vim.keymap.set('n', '<leader>tgf', builtin.git_files, { desc = 'Telescope list git files' })
    vim.keymap.set('n', '<leader>tgs', builtin.git_status, { desc = 'Telescope list git status' })
    -- misc
    vim.keymap.set('n', '<leader>tsb', show_fb, { desc = 'Telescope show file browser' })
    vim.keymap.set('n', '<leader>tsc', builtin.commands, { desc = 'Telescope show plugin commands' })
    vim.keymap.set('n', '<leader>tsC', builtin.command_history, { desc = 'Telescope show command history' })
    vim.keymap.set('n', '<leader>tsd', builtin.diagnostics, { desc = 'Telescope show diagnostics' })
    vim.keymap.set('n', '<leader>tsh', builtin.help_tags, { desc = 'Telescope show help tags' })
    vim.keymap.set('n', '<leader>tsj', builtin.jumplist, { desc = 'Telescope show jump list' })
    vim.keymap.set('n', '<leader>tsk', builtin.keymaps, { desc = 'Telescope show keymaps' })
    vim.keymap.set('n', '<leader>tsm', builtin.man_pages, { desc = 'Telescope show man pages' })
    vim.keymap.set('n', '<leader>tsr', builtin.registers, { desc = 'Telescope show registers' })
    vim.keymap.set('n', '<leader>ts;', builtin.marks, { desc = 'Telescope show marks' })
    -- lsp
    vim.keymap.set('n', '<leader>tld', builtin.lsp_definitions, { desc = 'Telescope LSP show definitions' })
    vim.keymap.set('n', '<leader>tli', builtin.lsp_implementations, { desc = 'Telescope LSP show implementations' })
    vim.keymap.set('n', '<leader>tlr', builtin.lsp_references, { desc = 'Telescope LSP show references' })
    vim.keymap.set('n', '<leader>tls', builtin.lsp_document_symbols, { desc = 'Telescope LSP show document symbols' })
    vim.keymap.set('n', '<leader>tlw', builtin.lsp_workspace_symbols, { desc = 'Telescope LSP show workspace symbols' })
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
    -- vim.keymap.set('n', '<leader>gb', '<cmd>GitBlame<cr>', { desc = 'Git open blame window' })
    -- vim.keymap.set('n', '<leader>gd', '<cmd>GitDiff<cr>', { desc = 'Git open diff window' })
    -- vim.keymap.set('n', '<leader>gD', '<cmd>GitDiffClose<cr>', { desc = 'Git close diff window' })

    vim.keymap.set('n', '<leader>gb', function() require('git.blame').blame() end, { desc = 'Git open blame window' })
    vim.keymap.set('n', '<leader>gd', function() require('git.diff').open() end, { desc = 'Git open diff window' })
    vim.keymap.set('n', '<leader>gD', function() require('git.diff').close() end, { desc = 'Git close diff window' })
    vim.keymap.set('n', '<leader>gn', function() require('git.browse').create_pull_request() end,
        { desc = 'Git create a pull request' })
    vim.keymap.set('n', '<leader>go', function() require('git.browse').open(false) end,
        { desc = 'Git open file / folder in repo' })
    vim.keymap.set('n', '<leader>gp', function() require('git.browse').pull_request() end,
        { desc = 'Git open pull request of current branch' })

    -- simple commands for complex activities - personally not recommended
    -- vim.keymap.set('n', '<leader>gr', function() require('git.revert').open(false) end,
    --     { desc = 'Git revert to spec. commit' })
    -- vim.keymap.set('n', '<leader>gR', function() require('git.revert').open(true) end,
    --     { desc = 'Git revert current file to spec. commit' })
end

local _, gitsigns = pcall(require, 'gitsigns')
if gitsigns then
    -- git diff gives better options to open and close
    -- use <leader>gdo and <leader>gdc instead, refer Git section for more details
    -- vim.keymap.set('n', '<leader>gd', function() require('gitsigns').diffthis() end, { desc = 'Git diff' })

    -- not using this option, git-messenger gives better config
    -- vim.keymap.set('n', '<leader>gl', function() require('gitsigns').blame_line() end, { desc = 'Git blame' })
    -- vim.keymap.set('n', '<leader>gL', function() require('gitsigns').blame_line { full = true } end,
    --     { desc = 'Git blame with details' })

    vim.keymap.set('n', '<leader>g]', gitsigns.next_hunk, { desc = 'Git next hunk' })
    vim.keymap.set('n', '<leader>g[', gitsigns.prev_hunk, { desc = 'Git prev hunk' })
    vim.keymap.set('n', '<leader>ghp', gitsigns.preview_hunk, { desc = 'Git hunk preview' })
    vim.keymap.set('n', '<leader>ghs', gitsigns.stage_hunk, { desc = 'Git hunk stage' })
    vim.keymap.set('n', '<leader>ghu', gitsigns.undo_stage_hunk, { desc = 'Git hunk unstage' })
    vim.keymap.set('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'Git hunk reset' })

    -- simple commands for complex activities - personally not recommended
    -- vim.keymap.set('n', '<leader>ghS', gitsigns.stage_buffer, { desc = 'Git buffer stage' })
    -- vim.keymap.set('n', '<leader>ghH', gitsigns.reset_buffer, { desc = 'Git buffer reset' })
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

-- Removing in favour of lspsaga outline
-- local _, aerial = pcall(require, 'aerial')
-- if aerial then
--     -- You probably also want to set a keymap to toggle aerial
--     vim.keymap.set('n', '<leader>ao', '<cmd>AerialToggle<CR>', { desc = 'Aerial toggle' })
--     vim.keymap.set('n', '<leader>an', '<cmd>AerialNavToggle<CR>', { desc = 'Aerial toggle nav window' })
-- end

-- Removing in favour of lspsaga outline
-- local _, symbols_outline = pcall(require, 'symbols-outline')
-- if symbols_outline then
--     vim.keymap.set('n', '<leader>so', '<cmd>SymbolsOutline<CR>', { desc = 'Symbols outline toggle' })
-- end

-- local _, goto_preview = pcall(require, 'goto-preview')
-- if goto_preview then
-- mappings are not possible due to conflicts
-- vim.keymap.set('n', '<leader>gpd', 'goto_preview.goto_preview_definition', { desc = 'Go to preview definition' })
-- vim.keymap.set('n', '<leader>gpt', 'goto_preview.goto_preview_type_definition',
--     { desc = 'Go to preview type definition' })
-- vim.keymap.set('n', '<leader>gpi', 'goto_preview.goto_preview_implementation',
--     { desc = 'Go to preview implementation' })
-- vim.keymap.set('n', '<leader>gP', 'goto_preview.close_all_win', { desc = 'Go to close all win' })
-- vim.keymap.set('n', '<leader>gpr', 'goto_preview.goto_preview_references', { desc = 'Go to preview references' })
-- end

local _, dap = pcall(require, 'dap')
if dap then
    vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'DAP continue' })
    -- vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
    -- vim.keymap.set("n", "<F3>", ":lua require'dap'.step_over()<CR>")
    -- vim.keymap.set("n", "<F2>", ":lua require'dap'.step_into()<CR>")
    -- vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>")
    -- vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
    -- vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
    -- vim.keymap.set("n", "<leader>lp",
    --     ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
    -- vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
    -- vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")
end

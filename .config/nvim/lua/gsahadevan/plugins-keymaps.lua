local keymap = vim.keymap.set -- Shorten function name

local _, cokeline = pcall(require, 'cokeline')
if cokeline then
    keymap('n', '<s-tab>', '<Plug>(cokeline-focus-prev)',
        { noremap = true, silent = true, desc = 'Cokeline focus prev buffer' })
    keymap('n', '<tab>', '<Plug>(cokeline-focus-next)',
        { noremap = true, silent = true, desc = 'Cokeline focus next buffer' })
    keymap('n', '<leader>p', '<Plug>(cokeline-switch-prev)',
        { noremap = true, silent = true, desc = 'Cokeline move current buffer backward' })
    keymap('n', '<leader>n', '<Plug>(cokeline-switch-next)',
        { noremap = true, silent = true, desc = 'Cokeline move current buffer forward' })
end

local _, vim_bbye = pcall(require, 'vim-bbye')
if vim_bbye then
    keymap('n', '<leader>w', ':Bdelete<cr>',
        { noremap = true, silent = true, desc = 'Close current buffer' })
    keymap('n', '<leader>W', ':Bdelete!<cr>',
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
            layout_config = {
                height = 0.4,
                width = 0.8,
            }
        })
    end

    -- Intention is to pass options to the existing pickers
    -- Ref: https://github.com/nvim-telescope/telescope.nvim/issues/848
    local opts = themes.get_dropdown {
        path_display = { 'absolute' },
        -- winblend = 10,
        previewer = false,
        layout_config = {
            height = 0.4,
            width = 0.8,
        },
    }

    local buffer_fuzzy_find = function()
        builtin.current_buffer_fuzzy_find(opts)
    end

    local find_open_buffers = function()
        builtin.buffers(opts)
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

    local show_lsp_definition_in_split = function()
        builtin.lsp_definitions({ jump_type = 'vsplit' })
    end

    -- See `:help telescope.builtin`
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    keymap('n', '<leader>/', buffer_fuzzy_find, { desc = 'Telescope fuzzy search in curr. buffer' })
    keymap('n', '<leader>?', builtin.oldfiles, { desc = 'Telescope find recently opened files' })
    keymap('n', '<leader><space>', find_open_buffers, { desc = 'Telescope show existing buffers' })

    keymap('n', '<leader>f<cr>', builtin.resume, { desc = 'Telescope find, resume previous search' })
    keymap('n', '<leader>fp', builtin.find_files, { desc = 'Telescope find files with preview' })
    keymap('n', '<leader>fP', find_files_all, { desc = 'Telescope find files with preview incl. hidden' })
    keymap('n', '<leader>ff', find_files_wo_preview, { desc = 'Telescope find files without preview' })
    keymap('n', '<leader>ft', find_color_schemes, { desc = 'Telescope find and preview themes' })

    keymap('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope search using live grep' })
    keymap('n', '<leader>sG', grep_search_all, { desc = 'Telescope search using live grep incl. hidden' })
    keymap('n', '<leader>fG', grep_search_args, { desc = 'Telescope search using live grep incl. args' })
    keymap('n', '<leader>sw', builtin.grep_string, { desc = 'Telescope search for word under cursor' })
    -- git
    keymap('n', '<leader>tgb', builtin.git_branches, { desc = 'Telescope list git branches' })
    keymap('n', '<leader>tgc', builtin.git_commits, { desc = 'Telescope list git commits' })
    keymap('n', '<leader>tgf', builtin.git_files, { desc = 'Telescope list git files' })
    keymap('n', '<leader>tgs', builtin.git_status, { desc = 'Telescope list git status' })
    -- misc
    keymap('n', '<leader>tsb', show_fb, { desc = 'Telescope show file browser' })
    keymap('n', '<leader>tsc', builtin.commands, { desc = 'Telescope show plugin commands' })
    keymap('n', '<leader>tsC', builtin.command_history, { desc = 'Telescope show command history' })
    keymap('n', '<leader>tsd', builtin.diagnostics, { desc = 'Telescope show diagnostics' })
    keymap('n', '<leader>tsh', builtin.help_tags, { desc = 'Telescope show help tags' })
    keymap('n', '<leader>tsj', builtin.jumplist, { desc = 'Telescope show jump list' })
    keymap('n', '<leader>tsk', builtin.keymaps, { desc = 'Telescope show keymaps' })
    keymap('n', '<leader>tsm', builtin.man_pages, { desc = 'Telescope show man pages' })
    keymap('n', '<leader>tsr', builtin.registers, { desc = 'Telescope show registers' })
    keymap('n', '<leader>ts;', builtin.marks, { desc = 'Telescope show marks' })
    -- lsp
    keymap('n', '<leader>vd', show_lsp_definition_in_split, { desc = 'Telescope LSP go to definition in vsplit' })
    keymap('n', '<leader>tld', builtin.lsp_definitions, { desc = 'Telescope LSP show definitions' })
    keymap('n', '<leader>tli', builtin.lsp_implementations, { desc = 'Telescope LSP show implementations' })
    keymap('n', '<leader>tlr', builtin.lsp_references, { desc = 'Telescope LSP show references' })
    keymap('n', '<leader>tls', builtin.lsp_document_symbols, { desc = 'Telescope LSP show document symbols' })
    keymap('n', '<leader>tlw', builtin.lsp_workspace_symbols, { desc = 'Telescope LSP show workspace symbols' })
end

local _, git = pcall(require, 'Git')
if git then
    keymap('n', '<leader>gb', function() require('git.blame').blame() end, { desc = 'Git open blame window' })
    keymap('n', '<leader>gd', function() require('git.diff').open() end, { desc = 'Git open diff window' })
    keymap('n', '<leader>gD', function() require('git.diff').close() end, { desc = 'Git close diff window' })
    keymap('n', '<leader>gn', function() require('git.browse').create_pull_request() end,
        { desc = 'Git create a pull request' })
    keymap('n', '<leader>go', function() require('git.browse').open(false) end,
        { desc = 'Git open file / folder in repo' })
    keymap('n', '<leader>gp', function() require('git.browse').pull_request() end,
        { desc = 'Git open pull request of current branch' })
end

local _, gitsigns = pcall(require, 'gitsigns')
if gitsigns then
    keymap('n', '<leader>g]', gitsigns.next_hunk, { desc = 'Git next hunk' })
    keymap('n', '<leader>g[', gitsigns.prev_hunk, { desc = 'Git prev hunk' })
    keymap('n', '<leader>ghp', gitsigns.preview_hunk, { desc = 'Git hunk preview' })
    keymap('n', '<leader>ghs', gitsigns.stage_hunk, { desc = 'Git hunk stage' })
    keymap('n', '<leader>ghu', gitsigns.undo_stage_hunk, { desc = 'Git hunk unstage' })
    keymap('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'Git hunk reset' })
end

local _, git_messenger = pcall(require, 'git-messenger')
if git_messenger then
    keymap('n', '<leader>gmo', '<cmd>GitMessenger<cr>', { desc = 'Git messenger open' })
    keymap('n', '<leader>gmc', '<cmd>GitMessengerClose<cr>', { desc = 'Git messenger close' })
end

local _, trouble = pcall(require, 'trouble')
if trouble then
    keymap('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { desc = 'Trouble toggle' })
    keymap('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>',
        { desc = 'Trouble show workspace diagnostics' })
    keymap('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>',
        { desc = 'Trouble show document diagnostics' })
    keymap('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { desc = 'Trouble show window location list' })
    keymap('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { desc = 'Trouble show quickfix list' })
    keymap('n', '<leader>xr', '<cmd>TroubleToggle lsp_references<cr>',
        { desc = 'Trouble show references under word cursor' })
    keymap('n', '<leader>xD', '<cmd>TroubleToggle lsp_definitions<cr>',
        { desc = 'Trouble show definitions under word cursor' })
    keymap('n', '<leader>xT', '<cmd>TroubleToggle lsp_type_definitions<cr>',
        { desc = 'Trouble show type definitions under word cursor' })
end

local _, lspsaga = pcall(require, 'lspsaga')
if lspsaga then
    keymap('n', 'gh', '<cmd>Lspsaga lsp_finder<cr>', { desc = 'Lspsaga open lsp finder' })
    keymap({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<cr>', { desc = 'Lspsaga show code actions' })
    -- symbols
    keymap('n', '<leader>o', '<cmd>Lspsaga outline<cr>', { desc = 'Lspsaga open symbols outline' })
    keymap('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { desc = 'Lspsaga show hover docs' })
    -- call heirarchy
    keymap('n', '<leader>ci', '<cmd>Lspsaga incoming_calls<cr>', { desc = 'Lspsaga show incoming call heirarchy' })
    keymap('n', '<leader>co', '<cmd>Lspsaga outgoing_calls<cr>', { desc = 'Lspsaga show outgoing call heirarchy' })
    -- definitions
    keymap('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', { desc = 'Lspsaga goto definition' })
    keymap('n', 'gD', '<cmd>Lspsaga peek_definition<cr>', { desc = 'Lspsaga peek definition' })
    keymap('n', 'gt', '<cmd>Lspsaga goto_type_definition<cr>', { desc = 'Lspsaga goto type definition' })
    keymap('n', 'gT', '<cmd>Lspsaga peek_type_definition<cr>', { desc = 'Lspsaga peek type definition' })
    -- diagnostics
    keymap('n', '<leader>sl', '<cmd>Lspsaga show_line_diagnostics<cr>', { desc = 'Lspsaga show line diagnostics' })
    keymap('n', '<leader>sc', '<cmd>Lspsaga show_cursor_diagnostics<cr>', { desc = 'Lspsaga show cursor diagnostics' })
    keymap('n', '<leader>sb', '<cmd>Lspsaga show_buf_diagnostics<cr>', { desc = 'Lspsaga show buffer diagnostics' })
    keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<cr>', { desc = 'Lspsaga jump to prev diagnostic' })
    keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<cr>', { desc = 'Lspsaga jump to next diagnostic' })
    keymap('n', '[E', function()
        require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { desc = 'Lspsaga goto prev diagnostic error' })
    keymap('n', ']E', function()
        require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { desc = 'Lspsaga goto next diagnostic error' })
    -- rename with lsp support
    keymap('n', 'gr', '<cmd>Lspsaga rename<cr>', { desc = 'Lspsaga rename' })
    keymap('n', 'gR', '<cmd>Lspsaga rename ++project<cr>', { desc = 'Lspsaga rename across project' })
    -- terminal
    keymap({ 'n', 't' }, '<c-\\>', '<cmd>Lspsaga term_toggle<cr>', { desc = 'Lspsaga toggle terminal' })
end

local _, todo_comments = pcall(require, 'todo-comments')
if todo_comments then
    keymap('n', ']t', todo_comments.jump_next, { desc = 'Todo Comment - jump to next' })
    keymap('n', '[t', todo_comments.jump_prev, { desc = 'Todo Comment - jump to prev' })
end

-- TODO: have to complete dap installation and define keymaps
local _, dap = pcall(require, 'dap')
if dap then
    keymap('n', '<F5>', function() require('dap').continue() end, { desc = 'DAP continue' })
    -- keymap("n", "<F5>", ":lua require'dap'.continue()<cr>")
    -- keymap("n", "<F3>", ":lua require'dap'.step_over()<cr>")
    -- keymap("n", "<F2>", ":lua require'dap'.step_into()<cr>")
    -- keymap("n", "<F12>", ":lua require'dap'.step_out()<cr>")
    -- keymap("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<cr>")
    -- keymap("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
    -- keymap("n", "<leader>lp",
    --     ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
    -- keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>")
    -- keymap("n", "<leader>dt", ":lua require'dap-go'.debug_test()<cr>")
end

local _, ranger = pcall(require, 'ranger-nvim')
if ranger then
    keymap('n', '<leader>ef', ranger.open, { desc = 'Ranger open' })
end

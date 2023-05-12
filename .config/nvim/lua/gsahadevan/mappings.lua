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
    vim.api.nvim_set_keymap('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true })
    vim.api.nvim_set_keymap('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>p', '<Plug>(cokeline-switch-prev)', { silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>n', '<Plug>(cokeline-switch-next)', { silent = true })
end

local _, vim_bbye = pcall(require, 'vim-bbye')
if vim_bbye then
    vim.api.nvim_set_keymap('n', '<leader>w', ':Bdelete<CR>', { noremap = true, silent = true })
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

    local buffer_fuzzy_find = function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end

    local find_files_all = function()
        builtin.find_files {
            hidden = true,
            no_ignore = true
        }
    end

    local find_files_wo_preview = function()
        builtin.find_files(themes.get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end

    local grep_search_all = function()
        builtin.live_grep {
            additional_args = function(args)
                return vim.list_extend(args, { '--hidden', '--no-ignore' })
            end,
        }
    end

    local find_color_schemes = function()
        builtin.colorscheme { enable_preview = true }
    end

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

    -- See `:help telescope.builtin`
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    vim.keymap.set('n', '<leader>/', buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer]' })
    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    vim.keymap.set('n', '<leader>f<cr>', builtin.resume, { desc = '[F]ind, resume previous search' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fF', find_files_all, { desc = '[F]ind [F]iles including hidden' })
    vim.keymap.set('n', '<leader>fp', find_files_wo_preview, { desc = '[F]ind [P]files without preview' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind [W]ord under cursor' })

    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sG', grep_search_all, { desc = '[S]earch by [G]rep including hidden' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sb', show_fb, { desc = '[S]how [B]rowser' })
    -- git
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [B]ranches' })
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[G]it [C]ommits' })
    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it [F]iles' })
    -- vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })
    -- misc
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[F]ind [O]ld files' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = '[F]ind [M]an pages' })
    vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = '[F]ind [R]egisters' })
    vim.keymap.set('n', '<leader>f;', builtin.marks, { desc = '[F]ind [;]Marks' })
    vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = '[F]ind [C]ommands' })
    vim.keymap.set('n', '<leader>fC', builtin.command_history, { desc = '[F]ind [C]ommands history' })
    vim.keymap.set('n', '<leader>ft', find_color_schemes, { desc = '[F]ind [T]hemes' })
    -- lsp
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = '[L]Show [S]ymbols' })
    vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = '[L]Show [W]orkspace symbols' })
    -- vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = '[L]Show [D]efinitions' })
    -- vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = '[L]Show [I]mplementations' })
    -- vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = '[L]Show [R]eferences' })
    --    if is_available 'nvim-notify' then
    --        maps.n['<leader>fn'] =
    --        { function() require('telescope').extensions.notify.notify() end, desc = 'Find notifications' }
    --    end

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

local _, gitsigns = pcall(require, 'gitsigns')
if gitsigns then
    vim.keymap.set('n', '<leader>]g', function() require('gitsigns').next_hunk() end, { desc = 'Next Git hunk' })
    vim.keymap.set('n', '<leader>[g', function() require('gitsigns').prev_hunk() end, { desc = 'Previous Git hunk' })
    vim.keymap.set('n', '<leader>gl', function() require('gitsigns').blame_line() end, { desc = 'View Git blame' })
    vim.keymap.set('n', '<leader>gL', function() require('gitsigns').blame_line { full = true } end,
        { desc = 'View full Git blame' })
    vim.keymap.set('n', '<leader>gp', function() require('gitsigns').preview_hunk() end, { desc = 'Preview Git hunk' })
    vim.keymap.set('n', '<leader>gh', function() require('gitsigns').reset_hunk() end, { desc = 'Reset Git hunk' })
    vim.keymap.set('n', '<leader>gr', function() require('gitsigns').reset_buffer() end, { desc = 'Reset Git buffer' })
    vim.keymap.set('n', '<leader>gs', function() require('gitsigns').stage_hunk() end, { desc = 'Stage Git hunk' })
    vim.keymap.set('n', '<leader>gS', function() require('gitsigns').stage_buffer() end, { desc = 'Stage Git buffer' })
    vim.keymap.set('n', '<leader>gu', function() require('gitsigns').undo_stage_hunk() end, { desc = 'Unstage Git hunk' })
    vim.keymap.set('n', '<leader>gd', function() require('gitsigns').diffthis() end, { desc = 'View Git diff' })
end

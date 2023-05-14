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

    local find_color_schemes = function()
        builtin.colorscheme { enable_preview = true }
    end

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

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
    -- vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'Telescope LSP show definitions' })
    -- vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = 'Telescope LSP show implementations' })
    -- vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'Telescope LSP show references' })
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
    vim.keymap.set('n', '<leader>gd', function() require('gitsigns').diffthis() end, { desc = 'Git diff' })
    vim.keymap.set('n', '<leader>gl', function() require('gitsigns').blame_line() end, { desc = 'Git blame' })
    vim.keymap.set('n', '<leader>gL', function() require('gitsigns').blame_line { full = true } end,
        { desc = 'Git blame with details' })
    vim.keymap.set('n', '<leader>g]', function() require('gitsigns').next_hunk() end, { desc = 'Git next hunk' })
    vim.keymap.set('n', '<leader>g[', function() require('gitsigns').prev_hunk() end, { desc = 'Git prev hunk' })
    vim.keymap.set('n', '<leader>gp', function() require('gitsigns').preview_hunk() end, { desc = 'Git preview hunk' })
    vim.keymap.set('n', '<leader>gs', function() require('gitsigns').stage_hunk() end, { desc = 'Git stage hunk' })
    vim.keymap.set('n', '<leader>gu', function() require('gitsigns').undo_stage_hunk() end, { desc = 'Git unstage hunk' })
    vim.keymap.set('n', '<leader>gh', function() require('gitsigns').reset_hunk() end, { desc = 'Git reset hunk' })
    vim.keymap.set('n', '<leader>gS', function() require('gitsigns').stage_buffer() end, { desc = 'Git stage buffer' })
    vim.keymap.set('n', '<leader>gH', function() require('gitsigns').reset_buffer() end, { desc = 'Git reset buffer' })
end

local status, telescope = pcall(require, 'telescope')
if not status then
    print('telescope is not installed')
    return
end

-- local actions = require('telescope.actions')
-- local builtin = require('telescope.builtin')
local fb_actions = require 'telescope'.extensions.file_browser.actions

telescope.setup {
    defaults = {
        path_display = { 'smart' },
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ['<C-h>'] = 'which_key',
                -- ['<C-n>'] = actions.cycle_history_next,
                -- ['<C-p>'] = actions.cycle_history_prev,
                --
                -- ['<C-j>'] = actions.move_selection_next,
                -- ['<C-k>'] = actions.move_selection_previous,
                --
                -- ['<C-c>'] = actions.close,
                --
                -- ['<Down>'] = actions.move_selection_next,
                -- ['<Up>'] = actions.move_selection_previous,
                --
                -- ['<CR>'] = actions.select_default,
                -- ['<C-x>'] = actions.select_horizontal,
                -- ['<C-v>'] = actions.select_vertical,
                -- ['<C-t>'] = actions.select_tab,
                --
                -- ['<C-u>'] = actions.preview_scrolling_up,
                -- ['<C-d>'] = actions.preview_scrolling_down,
                --
                -- ['<PageUp>'] = actions.results_scrolling_up,
                -- ['<PageDown>'] = actions.results_scrolling_down,
                --
                -- ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                -- ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                -- ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                -- ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                -- ['<C-l>'] = actions.complete_tag,
                -- ['<C-_>'] = actions.which_key, -- keys from pressing <C-/>
            },
            n = {
                -- ['<esc>'] = actions.close,
                -- ['<CR>'] = actions.select_default,
                -- ['<C-x>'] = actions.select_horizontal,
                -- ['<C-v>'] = actions.select_vertical,
                -- ['<C-t>'] = actions.select_tab,
                --
                -- ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                -- ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                -- ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                -- ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                --
                -- ['j'] = actions.move_selection_next,
                -- ['k'] = actions.move_selection_previous,
                -- ['H'] = actions.move_to_top,
                -- ['M'] = actions.move_to_middle,
                -- ['L'] = actions.move_to_bottom,
                --
                -- ['<Down>'] = actions.move_selection_next,
                -- ['<Up>'] = actions.move_selection_previous,
                -- ['gg'] = actions.move_to_top,
                -- ['G'] = actions.move_to_bottom,
                --
                -- ['<C-u>'] = actions.preview_scrolling_up,
                -- ['<C-d>'] = actions.preview_scrolling_down,
                --
                -- ['<PageUp>'] = actions.results_scrolling_up,
                -- ['<PageDown>'] = actions.results_scrolling_down,
                --
                -- ['?'] = actions.which_key,
            },
        },
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        file_browser = {
            theme = 'dropdown',
            hijack_netrw = false, -- to disable netrw and use telescopes file browser change to true
            mappings = {
                i = {
                    -- your custom insert mode mappings
                    ['<C-w>'] = function() vim.cmd('normal vbd') end,
                },
                n = {
                    -- your custom normal mode mappings
                    ['N'] = fb_actions.create,
                    ['h'] = fb_actions.goto_parent_dir,
                    ['/'] = function()
                        vim.cmd('startinsert')
                    end
                },
            },
        },
    },
}

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
        layout_config = { height = 40 }
    })
end

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- You can pass additional configuration to telescope to change theme, layout, etc.                                               •
vim.keymap.set('n', '<leader>/',
    function() require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        })
    end, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch with [R]esume' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sb', show_fb, { desc = '[S]how [B]rowser' })

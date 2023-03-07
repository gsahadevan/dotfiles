local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
    print('nvim-tree is not installed')
    return
end

local config_status_ok, nvim_tree_config = pcall(require, 'nvim-tree.config')
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
    disable_netrw = true,
    hijack_netrw = true,
    -- open_on_setup = false, -- use <leader>b to toggle now
    ignore_ft_on_setup = { 'dashboard' },
    -- auto_close = true, -- deprecated
    open_on_tab = true,
    hijack_cursor = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    renderer = {
        root_folder_modifier = ':t',
        icons = {
            webdev_colors = true,
            glyphs = {
                default = '',
                symlink = '',
                folder = {
                    -- arrow_closed = '⮁',
                    arrow_open = '',
                    arrow_closed = '',
                    default = '',
                    open = '',
                    empty = '',
                    empty_open = '',
                    symlink = '',
                    symlink_open = '',
                },
                git = {
                    unstaged = '',
                    staged = '✓',
                    unmerged = '',
                    renamed = '➜',
                    untracked = '★',
                    deleted = '',
                    ignored = '◌',
                },
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        -- icons = { error = '', warning = '', info = '', hint = '' },
        icons = { error = ' ', warning = ' ', hint = ' ', info = ' ' },
    },
    view = {
        width = 55,
        hide_root_folder = true,
        -- auto_resize = false,
        side = 'left',
        mappings = {
            list = {
                { key = { 'l', '<CR>', 'o' }, cb = tree_cb 'edit' },
                { key = 'h',                  cb = tree_cb 'close_node' },
                { key = 'v',                  cb = tree_cb 'vsplit' },
            },
        },
    },
}

-- To close nvim if nvim-tree is the last remaining window
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
-- Since auto_close is deprecated using the naive solution given in the above link
vim.api.nvim_create_autocmd('BufEnter', {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and require('nvim-tree.utils').is_nvim_tree_buf() then
            vim.cmd 'quit'
        end
    end
})

vim.api.nvim_set_keymap('n', '<leader>b', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

function higher()
    vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = 'orange' })
end

higher()

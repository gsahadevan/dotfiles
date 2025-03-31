-- Shorten function name
local keymap = vim.keymap.set

local _, lspsaga = pcall(require, 'lspsaga')
if lspsaga then
    -- Add keymaps for Lspsaga
    keymap('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { nowait = true, noremap = true, silent = true, desc = 'Show hover info of symbol under cursor' })
    keymap('n', 'gh', '<cmd>Lspsaga finder<cr>', { noremap = true, silent = true, desc = 'Show LSP finder' })
    keymap('n', '<leader>o', '<cmd>Lspsaga outline<cr>', { noremap = true, silent = true, desc = 'Open sysmbols outline' })
    keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', { noremap = true, silent = true, desc = 'Show code action available for cursor pos' }) -- changed from <f4>
    -- Lspsaga call heirarchy
    keymap('n', '<leader>ci', '<cmd>Lspsaga incoming_calls<cr>', { noremap = true, silent = true, desc = 'Show incoming call heirarchy' })
    keymap('n', '<leader>co', '<cmd>Lspsaga outgoing_calls<cr>', { noremap = true, silent = true, desc = 'Show outgoing call heirarchy' })
    -- Lspsaga definitions
    keymap('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', { nowait = true, noremap = true, silent = true, desc = 'Lspsaga goto definition' })
    keymap('n', 'gD', '<cmd>Lspsaga peek_definition<cr>', { nowait = true, noremap = true, silent = true, desc = 'Lspsaga peek definition' })
    keymap('n', 'gt', '<cmd>Lspsaga goto_type_definition<cr>', { nowait = true, noremap = true, silent = true, desc = 'Lspsaga goto type definition' })
    keymap('n', 'gT', '<cmd>Lspsaga peek_type_definition<cr>', { nowait = true, noremap = true, silent = true, desc = 'Lspsaga peek type definition' })
    -- Lspsaga diagnostics
    keymap('n', 'sl', '<cmd>Lspsaga show_line_diagnostics<cr>', { noremap = true, silent = true, desc = 'Show line diagnostics' })
    keymap('n', 'sc', '<cmd>Lspsaga show_cursor_diagnostics<cr>', { noremap = true, silent = true, desc = 'Show cursor diagnostics' })
    keymap('n', 'sb', '<cmd>Lspsaga show_buf_diagnostics<cr>', { noremap = true, silent = true, desc = 'Show buffer diagnostics' })
    keymap('n', 'g]', '<cmd>Lspsaga diagnostic_jump_prev<cr>', { noremap = true, silent = true, desc = 'Move to the prev diagnostic in current buffer' })
    keymap('n', 'g[', '<cmd>Lspsaga diagnostic_jump_next<cr>', { noremap = true, silent = true, desc = 'Move to the next diagnostic in current buffer' })
    -- Lspsaga misc
    keymap('n', '<leader>cr', '<cmd>Lspsaga rename<cr>', { noremap = true, silent = true, desc = 'Renames all references of symbol under cursor' })
    keymap('n', '<leader>cf', vim.lsp.buf.format, { noremap = true, silent = true, desc = 'Format code in current buffer' })
    keymap('n', '<leader>cq', vim.diagnostic.setloclist, { noremap = true, silent = true, desc = 'Open diagnostic set loc list' })
    -- https://stackoverflow.com/questions/67988374/neovim-lsp-auto-fix-fix-current
    -- To make sure you only apply relevant fixes, you can use the filter attribute and look for the "prefered" fixes.
    local function quickfix()
        vim.lsp.buf.code_action({
            filter = function(a) return a.isPreferred end,
            apply = true
        })
    end
    keymap('n', '<leader>qf', quickfix, { noremap = true, silent = true, desc = 'Format code by applying quickfix on code actions' })
end

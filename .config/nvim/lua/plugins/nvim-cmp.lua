local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 35
local MIN_LABEL_WIDTH = 35
local icons = require "icons.font-icons"

return {
    'hrsh7th/nvim-cmp',     -- autocompletion plugin
    dependencies = {
        'hrsh7th/cmp-buffer',   -- completion source for buffer words
        'hrsh7th/cmp-nvim-lua', -- completion source for lua
        'hrsh7th/cmp-path',     -- completion source for path
        'hrsh7th/cmp-cmdline',  -- completion source for path
        'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
        'L3MON4D3/LuaSnip',     -- snippet engine | needed for completion
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-d>']     = cmp.mapping.scroll_docs(-4),
                ['<C-f>']     = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>']     = cmp.mapping.close(),
                ['<CR>']      = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip' },
                { name = 'buffer',  option = { keyword_length = 5 } },
                { name = 'path' },
            }),
            window = {
                completion    = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
                -- winhighlight  = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                winhighlight  = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
                col_offset    = -3,
                side_padding  = 0,
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    -- add ellipsis and extra padding to match the width
                    local label = vim_item.abbr
                    local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
                    if truncated_label ~= label then
                        vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
                    elseif string.len(label) < MIN_LABEL_WIDTH then
                        local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
                        vim_item.abbr = label .. padding
                    end

                    vim_item.kind = string.format('%s%s', icons.Completion[vim_item.kind], vim_item.kind) -- add icons along with item kind
                    vim_item.menu = ({
                        nvim_lsp = '[LSP]',
                        nvim_lua = '[Lua]',
                        luasnip  = '[Snip]',
                        buffer   = '[Bufr]',
                        path     = '[Path]',
                    })[entry.source.name]
                    return vim_item
                end,
            },
        })
    end
}

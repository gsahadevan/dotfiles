local status, cmp = pcall(require, 'cmp')
if not status then
    print('cmp | completion is not installed')
    return
end

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 40
local MIN_LABEL_WIDTH = 40
local M = {}

M.icons = {
    Namespace     = '  ',
    Text          = '  ',
    Method        = '  ',
    Function      = '  ',
    Constructor   = '  ',
    Field         = '  ',
    Variable      = '  ',
    Class         = '  ',
    Interface     = '  ',
    Module        = '  ',
    Property      = '  ',
    Unit          = '  ',
    Value         = '  ',
    Enum          = '  ',
    Keyword       = '  ',
    Key           = '  ',
    Snippet       = '  ',
    Color         = '  ',
    File          = '  ',
    Reference     = '  ',
    Folder        = '  ',
    EnumMember    = '  ',
    Constant      = '  ',
    Struct        = '  ',
    Event         = '  ',
    Operator      = '  ',
    TypeParameter = '  ',
    Table         = '  ',
    Object        = '  ',
    Tag           = '  ',
    Array         = '[] ',
    Boolean       = '  ',
    Number        = '  ',
    Null          = 'ﳠ  ',
    String        = '  ',
    Calendar      = '  ',
    Watch         = '  ',
    Package       = '  ',
    Copilot       = '  ',
    Suggestion    = '  ',
}

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>']  = cmp.mapping.confirm({
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
        winhighlight  = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
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

            vim_item.kind = string.format('%s%s', M.icons[vim_item.kind], vim_item.kind) -- add icons along with item kind
            vim_item.menu = ({
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[Lua]',
                    luasnip  = '[Snippet]',
                    buffer   = '[Buffer]',
                    path     = '[Path]',
                })[entry.source.name]
            return vim_item
        end,
    },
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

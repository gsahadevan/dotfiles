local status, cmp = pcall(require, 'cmp')
if not status then
    print('cmp | completion is not installed')
    return
end

local lspkind = require 'lspkind'
local luasnip = require 'luasnip'

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
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' })
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    }),
    formatting = {
        -- fields = { 'kind', 'abbr', 'menu' }, -- changing the order of appearance
        -- format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
        format = lspkind.cmp_format({ with_text = true, maxwidth = 50 })
    },
    window = {
        completion = {
            border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        },
        documentation = {
            border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        },
    },
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

require('luasnip.loaders.from_vscode').lazy_load()

-- ' Use <Tab> and <S-Tab> to navigate through popup menu
-- inoremap <expr> <Tab>   pumvisible() ? '\<C-n>' : '\<Tab>'
-- inoremap <expr> <S-Tab> pumvisible() ? '\<C-p>' : '\<S-Tab>'

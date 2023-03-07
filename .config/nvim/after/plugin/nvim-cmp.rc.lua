-- local status, cmp = pcall(require, 'cmp')
-- if not status then
--     print('cmp | completion is not installed')
--     return
-- end
--
-- -- local lspkind = require 'lspkind'
-- local luasnip = require 'luasnip'
--
-- -- cmp.setup({
-- --     snippet = {
-- --         expand = function(args)
-- --             require('luasnip').lsp_expand(args.body)
-- --         end,
-- --     },
-- --     mapping = cmp.mapping.preset.insert({
-- --         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
-- --         ['<C-f>'] = cmp.mapping.scroll_docs(4),
-- --         ['<C-Space>'] = cmp.mapping.complete(),
-- --         ['<C-e>'] = cmp.mapping.close(),
-- --         ['<CR>'] = cmp.mapping.confirm({
-- --             behavior = cmp.ConfirmBehavior.Replace,
-- --             select = true
-- --         }),
-- --         ['<Tab>'] = cmp.mapping(function(fallback)
-- --             if cmp.visible() then
-- --                 cmp.select_next_item()
-- --             elseif luasnip.expand_or_jumpable() then
-- --                 luasnip.expand_or_jump()
-- --             else
-- --                 fallback()
-- --             end
-- --         end, { 'i', 's' }),
-- --         ['<S-Tab>'] = cmp.mapping(function(fallback)
-- --             if cmp.visible() then
-- --                 cmp.select_prev_item()
-- --             elseif luasnip.jumpable(-1) then
-- --                 luasnip.jump(-1)
-- --             else
-- --                 fallback()
-- --             end
-- --         end, { 'i', 's' })
-- --     }),
-- --     sources = cmp.config.sources({
-- --         { name = 'nvim_lsp' },
-- --         { name = 'luasnip' },
-- --         { name = 'buffer' },
-- --     }),
-- --     formatting = {
-- --         -- fields = { 'kind', 'abbr', 'menu' }, -- changing the order of appearance
-- --         -- format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
-- --         -- format = lspkind.cmp_format({ with_text = true, maxwidth = 50 })
-- --         format = lspkind.cmp_format({
-- --             mode = 'symbol_text', -- show only symbol annotations
-- --             maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
-- --             ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
-- --
-- --             -- The function below will be called before any actual modifications from lspkind
-- --             -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
-- --             -- before = function (entry, vim_item)
-- --             --   ...
-- --             --   return vim_item
-- --             -- end
-- --         })
-- --     },
-- --     window = {
-- --         completion = {
-- --             border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
-- --         },
-- --         documentation = {
-- --             border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
-- --         },
-- --         -- documentations from here https://github.com/hrsh7th/nvim-cmp/issues/671
-- --     --     completion = cmp.config.window.bordered({
-- --     --   winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
-- --     -- }),
-- --     },
-- -- })
-- --
-- -- vim.cmd [[
-- --   set completeopt=menuone,noinsert,noselect
-- --   highlight! default link CmpItemKind CmpItemMenuDefault
-- -- ]]
--
-- -- require('luasnip.loaders.from_vscode').lazy_load()
--
-- -- ' Use <Tab> and <S-Tab> to navigate through popup menu
-- -- inoremap <expr> <Tab>   pumvisible() ? '\<C-n>' : '\<Tab>'
-- -- inoremap <expr> <S-Tab> pumvisible() ? '\<C-p>' : '\<S-Tab>'
--
-- local lsp_symbols = {
--     Text = "   (Text) ",
--     Method = "   (Method)",
--     Function = "   (Function)",
--     Constructor = "   (Constructor)",
--     Field = " ﴲ  (Field)",
--     Variable = "[] (Variable)",
--     Class = "   (Class)",
--     Interface = " ﰮ  (Interface)",
--     Module = "   (Module)",
--     Property = " 襁 (Property)",
--     Unit = "   (Unit)",
--     Value = "   (Value)",
--     Enum = " 練 (Enum)",
--     Keyword = "   (Keyword)",
--     Snippet = "   (Snippet)",
--     Color = "   (Color)",
--     File = "   (File)",
--     Reference = "   (Reference)",
--     Folder = "   (Folder)",
--     EnumMember = "   (EnumMember)",
--     Constant = " ﲀ  (Constant)",
--     Struct = " ﳤ  (Struct)",
--     Event = "   (Event)",
--     Operator = "   (Operator)",
--     TypeParameter = "   (TypeParameter)",
-- }
--
-- cmp.setup({
--     sources = {
--         { name = "buffer" },
--         { name = "nvim_lsp" },
--         { name = "luasnip" },
--         { name = "neorg" },
--     },
--     mapping = {
--         ["<cr>"] = cmp.mapping.confirm({select = true}),
--         ["<s-tab>"] = cmp.mapping.select_prev_item(),
--         ["<tab>"] = cmp.mapping.select_next_item(),
--     },
--     formatting = {
--         format = function(entry, item)
--             -- item.kind = lsp_symbols[item.kind]
--             -- item.menu = ({
--             --     buffer = "[Buffer]",
--             --     nvim_lsp = "[LSP]",
--             --     luasnip = "[Snippet]",
--             --     neorg = "[Neorg]",
--             -- })[entry.source.name]
--             -- return item
--             -- if entry.source.name == "buffer" then
--             --     item.menu = "[Buffer]"
--             -- elseif entry.source.name == "nvim_lsp" then
--             --     item.menu = '{' .. entry.source.source.client.name .. '}'
--             -- else
--             --     item.menu = '[' .. entry.source.name .. ']'
--             -- end
--             -- if entry.completion_item.detail ~= nil and entry.completion_item.detail ~= "" then
--             --     item.menu = entry.completion_item.detail
--             -- else
--             --     item.kind = entry.completion_item.detail
--             --     item.menu = ({
--             --         buffer = "[Buffer]",
--             --         nvim_lsp = "[LSP]",
--             --         luasnip = "[Snippet]",
--             --         path = "[Path]",
--             --         neorg = "[Neorg]",
--             --     })[entry.source.name]
--             -- end
--             -- item.kind = string.format('%s %s', lsp_symbols[item.kind], entry.completion_item)
--             return item
--         end,
--     },
--     snippet = {
--         expand = function(args)
--             luasnip.lsp_expand(args.body)
--         end,
--     },
--     window = {
--         completion = {
--             border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
--         },
--         documentation = {
--             border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
--         },
--     },
-- })


-- local status, cmp = pcall(require, 'cmp')
-- if not status then
--     print('cmp | completion is not installed')
--     return
-- end
--
-- local lspkind = require 'lspkind'
-- local luasnip = require 'luasnip'
--
-- cmp.setup({
--     snippet = {
--         expand = function(args)
--             require('luasnip').lsp_expand(args.body)
--         end,
--     },
--     mapping = cmp.mapping.preset.insert({
--         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<C-e>'] = cmp.mapping.close(),
--         ['<CR>'] = cmp.mapping.confirm({
--             behavior = cmp.ConfirmBehavior.Replace,
--             select = true
--         }),
--         ['<Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif luasnip.expand_or_jumpable() then
--                 luasnip.expand_or_jump()
--             else
--                 fallback()
--             end
--         end, { 'i', 's' }),
--         ['<S-Tab>'] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--                 luasnip.jump(-1)
--             else
--                 fallback()
--             end
--         end, { 'i', 's' })
--     }),
--     sources = cmp.config.sources({
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' },
--         { name = 'buffer' },
--     }),
--     formatting = {
--         -- fields = { 'kind', 'abbr', 'menu' }, -- changing the order of appearance
--         -- format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
--         format = lspkind.cmp_format({ with_text = true, maxwidth = 50 })
--     },
--     window = {
--         completion = {
--             border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
--         },
--         documentation = {
--             border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
--         },
--     },
-- })
--
-- vim.cmd [[
--   set completeopt=menuone,noinsert,noselect
--   highlight! default link CmpItemKind CmpItemMenuDefault
-- ]]
--
-- require('luasnip.loaders.from_vscode').lazy_load()
--
-- -- ' Use <Tab> and <S-Tab> to navigate through popup menu
-- -- inoremap <expr> <Tab>   pumvisible() ? '\<C-n>' : '\<Tab>'
-- -- inoremap <expr> <S-Tab> pumvisible() ? '\<C-p>' : '\<S-Tab>'
local status, cmp = pcall(require, "cmp")
if (not status) then return end
-- local lspkind = require 'lspkind'

-- local function formatForTailwindCSS(entry, vim_item)
--     if vim_item.kind == 'Color' and entry.completion_item.documentation then
--         local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
--         if r then
--             local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
--             local group = 'Tw_' .. color
--             if vim.fn.hlID(group) < 1 then
--                 vim.api.nvim_set_hl(0, group, { fg = '#' .. color })
--             end
--             vim_item.kind = "●"
--             vim_item.kind_hl_group = group
--             return vim_item
--         end
--     end
--     vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
--     return vim_item
-- end

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
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    }),
    -- formatting = {
    --     format = lspkind.cmp_format({
    --         maxwidth = 50,
    --         before = function(entry, vim_item)
    --             vim_item = formatForTailwindCSS(entry, vim_item)
    --             return vim_item
    --         end
    --     })
    -- }
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

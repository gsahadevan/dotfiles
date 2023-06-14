local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 30
local MIN_LABEL_WIDTH = 30
local icons = require 'icons.font-icons'

return {
    'hrsh7th/nvim-cmp',         -- autocompletion plugin
    dependencies = {
        'hrsh7th/cmp-buffer',   -- completion source for buffer words
        'hrsh7th/cmp-nvim-lua', -- completion source for lua
        'hrsh7th/cmp-path',     -- completion source for path
        'hrsh7th/cmp-cmdline',  -- completion source for path
        'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
        'L3MON4D3/LuaSnip',     -- snippet engine | needed for completion
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
        'SirVer/ultisnips',
        'quangnguyen30192/cmp-nvim-ultisnips',
        'dcampos/nvim-snippy',
        'dcampos/cmp-snippy',
    },
    config = function()
        local function get_lsp_completion_context(completion, source)
            local status, source_name = pcall(function() return source.source.client.config.name end)
            if not status then
                return nil
            end

            if source_name == 'tsserver' then
                return completion.detail
            elseif source_name == 'gopls' then -- testing for gopls
                return completion.detail
            elseif source_name == 'pyright' then
                if completion.labelDetails ~= nil then
                    return completion.labelDetails.description
                end
            else
                return 'No source'
            end
        end

        -- local WIN_HIGHLIGHT = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:Search'
        local WIN_HIGHLIGHT = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:Search'
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
                { name = 'luasnip', option = { keyword_length = 3 } },
                { name = 'buffer',  option = { keyword_length = 3 } },
                { name = 'path',    option = { keyword_length = 3 } },
            }),
            window = {
                -- completion    = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
                completion    = cmp.config.window.bordered({ winhighlight = WIN_HIGHLIGHT }),
                documentation = cmp.config.window.bordered({ winhighlight = WIN_HIGHLIGHT }),
                preview       = cmp.config.window.bordered({ winhighlight = WIN_HIGHLIGHT }),
                -- winhighlight  = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                -- winhighlight  = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
                col_offset    = -3,
                side_padding  = 0,
                max_width     = 50,
            },
            formatting = {
                fields = { 'abbr', 'kind', 'menu' },
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

                    -- add icons along with item kind
                    vim_item.kind = string.format('%s%s', icons.Completion[vim_item.kind], vim_item.kind)
                    vim_item.menu = ({
                        nvim_lsp = '_lsp ',
                        nvim_lua = '_lua ',
                        luasnip  = 'snip ',
                        buffer   = 'bufr ',
                        path     = 'path ',
                    })[entry.source.name]

                    -- Add the completions source file path
                    -- https://www.reddit.com/r/neovim/comments/128ndxk/how_to_show_file_path_or_library_in_cmpsnippet/
                    -- Ref: https://github.com/giuseppe-g-gelardi/nvim/blob/mac/after/plugin/cmp.lua
                    -- Ref: https://github.com/ditsuke/nvim-config --> the github account of the user who posted the answer on reddit
                    local completion_context = get_lsp_completion_context(entry.completion_item, entry.source)
                    if completion_context ~= nil and completion_context ~= "" then
                        vim_item.menu = vim_item.menu .. completion_context
                    end
                    vim_item.menu = string.sub(vim_item.menu, 1, 25)

                    return vim_item
                end,
            },
        })

        local luasnip = require('luasnip')
        local s = luasnip.snippet
        local t = luasnip.text_node
        local i = luasnip.insert_node
        local types = require('luasnip.util.types')

        luasnip.setup({
            history = true,
            -- Update more often, :h events for more info.
            update_events = 'TextChanged,TextChangedI',
            -- Snippets aren't automatically removed if their text is deleted.
            -- `delete_check_events` determines on which events (:h events) a check for
            -- deleted snippets is performed.
            -- This can be especially useful when `history` is enabled.
            delete_check_events = 'TextChanged',
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { 'choiceNode', 'Comment' } },
                    },
                },
            },
            -- treesitter-hl has 100, use something higher (default is 200).
            ext_base_prio = 300,
            -- minimal increase in priority.
            ext_prio_increase = 1,
            enable_autosnippets = true,
            -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
            -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
            store_selection_keys = '<Tab>',
            -- luasnip uses this function to get the currently active filetype. This
            -- is the (rather uninteresting) default, but it's possible to use
            -- eg. treesitter for getting the current filetype by setting ft_func to
            -- require("luasnip.extras.filetype_functions").from_cursor (requires
            -- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
            -- the current filetype in eg. a markdown-code block or `vim.cmd()`.
            ft_func = function()
                ---@diagnostic disable-next-line: param-type-mismatch
                return vim.split(vim.bo.filetype, '.', true)
            end,
        })

        luasnip.add_snippets('lua', {
            s('pt', { t('print('), i(1, '...'), t(')') }),
            s('ipt', { t('print(vim.inspect({'), i(1, '...'), t('}))') }),
            s('fn',
                { t('local '), i(1), t(' = function('), i(2, 'args'), t({ ')', '\t' }), i(3, '...'), t({ '', 'end' }) }),
            s('mfn', { t('M.'), i(1), t(' = function( '), i(2), t({ ')', '\t' }), i(3), t({ '', 'end' }) }),
        })

        luasnip.add_snippets('typescript', {
            s('log', { t('console.log('), i(1), t(')') }),
            s('err', { t('console.error('), i(1), t(')') }),
            s('oimp', { t('import { '), i(1), t(' } from "'), i(2), t('"') }),
            s('exp', { t('export { '), i(1), t(' }"') }),
        })

        require('luasnip.loaders.from_vscode').lazy_load()
    end
}

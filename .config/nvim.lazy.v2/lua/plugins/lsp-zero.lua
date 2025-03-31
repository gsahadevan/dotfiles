return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
        { 'rafamadriz/friendly-snippets' },
        { 'saadparwaiz1/cmp_luasnip' },
    },
    config = function()
        local lsp = require('lsp-zero').preset({})
        lsp.on_attach(function(_, bufnr)
            lsp.default_keymaps({
                buffer = bufnr,
                -- preserve_mappings = false -- read here for more understanding - https://github.com/VonHeikemen/lsp-zero.nvim#keybindings
            })
        end)
        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls()) -- (optional) configure lua language server for neovim
        require('lspconfig.ui.windows').default_options.border = 'rounded'
        lsp.setup()

        -- Configure completion
        -- You need to setup `cmp` after lsp-zero
        --
        -- Required for logging / testing
        -- local log = require('plenary.log').new({
        --     level = 'debug'
        -- })
        -- Call the logging by log.debug('----------')
        -- logs would be found in :messages
        --
        local ELLIPSIS_CHAR = '…'
        local MAX_LABEL_WIDTH = 25
        local MIN_LABEL_WIDTH = 25
        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()
        require('luasnip')
        require('luasnip.loaders.from_vscode').load {}
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users
                end,
            },
            mapping = {
                -- `Enter` key to confirm completion
                ['<cr>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                }),
                -- Ctrl+Space to trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),
                -- Navigate between snippet placeholder
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip', },
                { name = 'buffer',  keyword_length = 3 },
                { name = 'path',    keyword_length = 3 },
            },
            window = {
                completion = cmp.config.window.bordered({
                    winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:Search'
                }),
                documentation = cmp.config.window.bordered({
                    winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:Search'
                }),
                preview = cmp.config.window.bordered({
                    winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:Search'
                }),
                col_offset = -3,
                side_padding = 0,
                max_width = 100,
                min_width = 100,
            },
            formatting = {
                -- fields = { 'abbr', 'kind', 'menu' },
                fields = { 'abbr', 'menu' },
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
                    -- Add the kind, check if you could somehow add icons
                    -- Would help save some space
                    vim_item.kind = string.format('%s', vim_item.kind)
                    -- Add vscode style export names at the end
                    -- Again, source name might not be required
                    local return_type = entry:get_completion_item()
                    local source_name = ({
                        nvim_lsp = '_lsp ',
                        nvim_lua = '_lua ',
                        luasnip  = 'snip ',
                        buffer   = 'bufr ',
                        path     = 'path ',
                    })[entry.source.name]
                    if return_type ~= nil and return_type.data ~= nil and return_type.data.entryNames ~= nil then
                        -- if return_type.data.entryNames[1] ~= nil and return_type.data.entryNames[1].data ~= nil and return_type.data.entryNames[1].data.exportName ~= nil then
                        if return_type.data.entryNames[1] ~= nil and return_type.data.entryNames[1].source ~= nil then
                            -- log.debug('------------------------------------')
                            -- log.debug('name: ' .. vim_item.abbr)
                            -- log.debug(return_type)
                            -- vim_item.menu = return_type.data.entryNames[1].data.exportName
                            vim_item.menu = return_type.data.entryNames[1].source
                        else
                            vim_item.menu = source_name
                        end
                    else
                        vim_item.menu = source_name
                    end

                    local menu = vim_item.menu
                    local truncated_menu = vim.fn.strcharpart(menu, 0, MAX_LABEL_WIDTH)
                    if truncated_menu ~= menu then
                        vim_item.menu = truncated_menu .. ELLIPSIS_CHAR
                    elseif string.len(menu) < MIN_LABEL_WIDTH then
                        local padding = string.rep(' ', MIN_LABEL_WIDTH - string.len(menu))
                        vim_item.menu = menu .. padding
                    end

                    return vim_item
                end,
            },
        })
    end,
}

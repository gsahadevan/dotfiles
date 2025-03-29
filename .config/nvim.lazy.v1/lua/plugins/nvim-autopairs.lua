return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- opts = {} -- this is equalent to setup({}) function
    opts = {
        check_ts = true,
        ts_config = {
            lua = { 'string', 'source' },
            javascript = { 'string', 'template_string' },
            java = false,
        },
        disable_filetype = { 'TelescopePrompt', 'vim', 'neo-tree' },
    }
}

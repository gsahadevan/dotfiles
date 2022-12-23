local status, nvim_autopairs = pcall(require, 'nvim-autopairs')
if not status then
    print('nvim-autopairs is not installed')
    return
end

nvim_autopairs.setup({
    check_ts = true,
    ts_config = {
        lua = { 'string', 'source' },
        javascript = { 'string', 'template_string' },
        java = false,
    },
    disable_filetype = { 'TelescopePrompt', 'vim' },
})

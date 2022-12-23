local status, mason = pcall(require, 'mason')
if not status then
    print('mason is not installed')
    return
end

mason.setup({})

local status_lspconfig, lspconfig = pcall(require, 'mason-lspconfig')
if not status_lspconfig then
    print('mason-lspconfig is not installed')
    return
end

lspconfig.setup {
  automatic_installation = true
}

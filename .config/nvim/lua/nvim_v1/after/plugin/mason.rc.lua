local status, mason = pcall(require, 'mason')
if (not status) then return end

mason.setup({})

local status_lspconfig, lspconfig = pcall(require, 'mason-lspconfig')
if (not status_lspconfig) then return end

lspconfig.setup {
  automatic_installation = true
}

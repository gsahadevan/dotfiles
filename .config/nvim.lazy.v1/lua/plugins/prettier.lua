return {
    'MunifTanjim/prettier.nvim', -- prettier plugin for neovim's built-in LSP client
    opts = {
        bin = 'prettierd',
        filetypes = {
            'css',
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'json',
            'scss',
            'less',
            'lua'
        }
    }
}

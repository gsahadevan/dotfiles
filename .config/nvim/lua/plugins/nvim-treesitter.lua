return {
    -- nvim-treesitter-textobjects
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        depedencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    -- nvim-treesitter-playground
    { 'nvim-treesitter/playground' },
    -- nvim-treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update({ with_sync = true }))
        end,
    },
}

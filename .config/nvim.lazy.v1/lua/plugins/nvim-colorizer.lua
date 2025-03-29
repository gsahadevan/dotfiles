return {
    'norcalli/nvim-colorizer.lua', -- shows colors on hex codes
    config = function()
        -- Attaches to every file type
        require('colorizer').setup()
    end,
}

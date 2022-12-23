local status, gitsigns = pcall(require, 'gitsigns')
if not status then
    print('gitsigns is not installed')
    return
end

-- See `:help gitsigns.txt`
gitsigns.setup {}

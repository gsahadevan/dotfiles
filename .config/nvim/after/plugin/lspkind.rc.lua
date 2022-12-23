local status, lspkind = pcall(require, 'lspkind')
if not status then
    print('lspkind is not installed')
    return
end

lspkind.init({
    mode = 'symbol',
    preset = 'codicons',
})

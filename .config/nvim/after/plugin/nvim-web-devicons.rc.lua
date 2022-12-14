local status, nvim_web_devicons = pcall(require, 'nvim-web-devicons')
if not status then
    print('nvim-web-devicons is not installed')
    return
end

nvim_web_devicons.setup {
  -- your personnal icons can go here (to override)
  -- DevIcon will be appended to `name`
  override = {},
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true
}

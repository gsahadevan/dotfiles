local colorscheme = "tokyonight"

local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status then
  return
end

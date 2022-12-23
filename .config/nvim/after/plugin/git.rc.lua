local status, git = pcall(require, 'git')
if not status then
    print('git is not installed')
    return
end

git.setup({
  keymaps = {
    blame = '<Leader>gb', -- Open blame window
    browse = '<Leader>go', -- Open file/folder in git repository
  }
})

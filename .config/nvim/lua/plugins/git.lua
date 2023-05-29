return {
    'dinhhuy258/git.nvim',                      -- for git blame & browse
    opts = {
        default_mappings = true,                -- NOTE: `quit_blame` and `blame_commit` are still merged to the keymaps even if `default_mappings = false`
        keymaps = {
            blame = '<leader>gb',               -- Open blame window
            quit_blame = 'q',                   -- Close blame window
            blame_commit = '<cr>',              -- Open blame commit
            browse = '<leader>go',              -- Open file/folder in git repository
            open_pull_request = '<leader>gp',   -- Open pull request of the current branch
            create_pull_request = '<leader>gn', -- Create a pull request with the target branch is set in the `target_branch` option
            diff = '<leader>gd',                -- Opens a new diff that compares against the current index
            diff_close = '<leader>gD',          -- Close git diff
            revert = '<leader>gr',              -- Revert to the specific commit
            revert_file = '<leader>gR',         -- Revert the current file to the specific commit
        },
        target_branch = 'master',               -- Default target branch when create a pull request
    },
}

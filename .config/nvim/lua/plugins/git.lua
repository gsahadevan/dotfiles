return {
    'dinhhuy258/git.nvim', -- for git blame & browse
    opts = {
        default_mappings = true, -- NOTE: `quit_blame` and `blame_commit` are still merged to the keymaps even if `default_mappings = false`
        keymaps = {
            -- Open blame window
            blame = '<leader>gb',
            -- Close blame window
            quit_blame = 'q',
            -- Open blame commit
            blame_commit = '<cr>',
            -- Open file/folder in git repository
            browse = '<leader>go',
            -- Open pull request of the current branch
            open_pull_request = '<leader>gp',
            -- Create a pull request with the target branch is set in the `target_branch` option
            create_pull_request = '<leader>gn',
            -- Opens a new diff that compares against the current index
            diff = '<leader>gd',
            -- Close git diff
            diff_close = '<leader>gD',
            -- Revert to the specific commit
            revert = '<leader>gr',
            -- Revert the current file to the specific commit
            revert_file = '<leader>gR',
        },
        -- Default target branch when create a pull request
        target_branch = 'master',
    },
}

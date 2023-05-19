return {
    'rhysd/git-messenger.vim', -- shows history of commits under cursor in a pop window
    opts = {
        -- add plugin options here
    },
}

-- The following mappings are defined within the popup window
-- Map	Description
-- q	Close the popup window
-- o	Older. Back to older commit at the line
-- O	Opposite to o. Forward to newer commit at the line
-- d	Toggle unified diff hunks only in current file of the commit
-- D	Toggle all unified diff hunks of the commit
-- r	Toggle word diff hunks only in current file of the commit
-- R	Toggle all word diff hunks of current commit
-- ?	Show mappings help

-- A tree like view for symbols in Neovim using the Language Server Protocol.
-- Supports all your favourite languages.
return {
    'simrat39/symbols-outline.nvim',
    opts = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = 'right',
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = 'Pmenu',
        autofold_depth = nil,
        auto_unfold_hover = true,
        fold_markers = { '', '' },
        wrap = false,
        keymaps = {
            -- These keymaps can be a string or a table for multiple keys
            close = { "<Esc>", "q" },
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            toggle_preview = "K",
            rename_symbol = "r",
            code_actions = "a",
            fold = "h",
            unfold = "l",
            fold_all = "W",
            unfold_all = "E",
            fold_reset = "R",
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        symbols = {
            File          = { icon = "", hl = "@text.uri" },
            Module        = { icon = "", hl = "@namespace" },
            Namespace     = { icon = "", hl = "@namespace" },
            Package       = { icon = "", hl = "@namespace" },
            Class         = { icon = "𝓒", hl = "@type" },
            Method        = { icon = "ƒ", hl = "@method" },
            Property      = { icon = "", hl = "@method" },
            Field         = { icon = "", hl = "@field" },
            Constructor   = { icon = "", hl = "@constructor" },
            Enum          = { icon = "ℰ", hl = "@type" },
            Interface     = { icon = "ﰮ", hl = "@type" },
            Function      = { icon = "", hl = "@function" },
            Variable      = { icon = "", hl = "@constant" },
            Constant      = { icon = "", hl = "@constant" },
            String        = { icon = "𝓐", hl = "@string" },
            Number        = { icon = "#", hl = "@number" },
            Boolean       = { icon = "⊨", hl = "@boolean" },
            Array         = { icon = "", hl = "@constant" },
            Object        = { icon = "⦿", hl = "@type" },
            Key           = { icon = "🔐", hl = "@type" },
            Null          = { icon = "NULL", hl = "@type" },
            EnumMember    = { icon = "", hl = "@field" },
            Struct        = { icon = "𝓢", hl = "@type" },
            Event         = { icon = "🗲", hl = "@type" },
            Operator      = { icon = "+", hl = "@operator" },
            TypeParameter = { icon = "𝙏", hl = "@parameter" },
            Component     = { icon = "", hl = "@function" },
            Fragment      = { icon = "", hl = "@constant" },
        },
    }
}


-- Commands
-- Command	                Description
-- :SymbolsOutline	        Toggle symbols outline
-- :SymbolsOutlineOpen	    Open symbols outline
-- :SymbolsOutlineClose	    Close symbols outline
--
-- Default keymaps
-- Key	                    Action
-- Escape	                Close outline
-- Enter	                Go to symbol location in code
-- o	                    Go to symbol location in code without losing focus
-- Ctrl+Space	            Hover current symbol
-- K	                    Toggles the current symbol preview
-- r	                    Rename symbol
-- a	                    Code actions
-- h	                    fold symbol
-- l	                    Unfold symbol
-- W	                    Fold all symbols
-- E	                    Unfold all symbols
-- R	                    Reset all folding
-- ?	                    Show help message
--
-- Highlights
-- Highlight	            Purpose
-- FocusedSymbol	        Highlight of the focused symbol
-- Pmenu	                Highlight of the preview popup windows
-- SymbolsOutlineConnector  Highlight of the table connectors
-- Comment	                Highlight of the info virtual text

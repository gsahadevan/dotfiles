local status, telescope = pcall(require, 'telescope')
if (not status) then return end

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local fb_actions = require 'telescope'.extensions.file_browser.actions

telescope.setup {
	defaults = {
		path_display = { 'smart' },
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key",
				-- ["<C-n>"] = actions.cycle_history_next,
				-- ["<C-p>"] = actions.cycle_history_prev,
				--
				-- ["<C-j>"] = actions.move_selection_next,
				-- ["<C-k>"] = actions.move_selection_previous,
				--
				-- ["<C-c>"] = actions.close,
				--
				-- ["<Down>"] = actions.move_selection_next,
				-- ["<Up>"] = actions.move_selection_previous,
				--
				-- ["<CR>"] = actions.select_default,
				-- ["<C-x>"] = actions.select_horizontal,
				-- ["<C-v>"] = actions.select_vertical,
				-- ["<C-t>"] = actions.select_tab,
				--
				-- ["<C-u>"] = actions.preview_scrolling_up,
				-- ["<C-d>"] = actions.preview_scrolling_down,
				--
				-- ["<PageUp>"] = actions.results_scrolling_up,
				-- ["<PageDown>"] = actions.results_scrolling_down,
				--
				-- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				-- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				-- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				-- ["<C-l>"] = actions.complete_tag,
				-- ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},
			n = {
				-- ["<esc>"] = actions.close,
				-- ["<CR>"] = actions.select_default,
				-- ["<C-x>"] = actions.select_horizontal,
				-- ["<C-v>"] = actions.select_vertical,
				-- ["<C-t>"] = actions.select_tab,
				--
				-- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				-- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				-- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				--
				-- ["j"] = actions.move_selection_next,
				-- ["k"] = actions.move_selection_previous,
				-- ["H"] = actions.move_to_top,
				-- ["M"] = actions.move_to_middle,
				-- ["L"] = actions.move_to_bottom,
				--
				-- ["<Down>"] = actions.move_selection_next,
				-- ["<Up>"] = actions.move_selection_previous,
				-- ["gg"] = actions.move_to_top,
				-- ["G"] = actions.move_to_bottom,
				--
				-- ["<C-u>"] = actions.preview_scrolling_up,
				-- ["<C-d>"] = actions.preview_scrolling_down,
				--
				-- ["<PageUp>"] = actions.results_scrolling_up,
				-- ["<PageDown>"] = actions.results_scrolling_down,
				--
				-- ["?"] = actions.which_key,
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
    		-- picker_name = {
    		--   picker_config_key = value,
    		--   ...
    		-- }
    		-- Now the picker_config_key will be applied every time you call this
    		-- builtin picker
  	},
	extensions = {
	  	-- Your extension configuration goes here:
	    	-- extension_name = {
	    	--   extension_config_key = value,
	    	-- }
	    	-- please take a look at the readme of the extension you want to configure
		file_browser = {
			theme = 'dropdown',
			hijack_netrw = false, -- to disable netrw and use telescopes file browser change to true
			mappings = {
				i = {
					-- your custom insert mode mappings
					["<C-w>"] = function() vim.cmd('normal vbd') end,
				},
				n = {
          				-- your custom normal mode mappings
					["N"] = fb_actions.create,
          				["h"] = fb_actions.goto_parent_dir,
          				["/"] = function()
            					vim.cmd('startinsert')
          				end
        			},
      			},
		},
	},
}

telescope.load_extension('file_browser')

local find_files = function()
	builtin.find_files({
		no_ignore = false,
		hidden = true
	})
end

local live_grep = function()
  	builtin.live_grep()
end

local buffers = function()
  	builtin.buffers()
end

local help_tags = function()
  	builtin.help_tags()
end

local resume = function()
  	builtin.resume()
end

local diagnostics = function()
  	builtin.diagnostics()
end

local function telescope_buffer_dir()
  	return vim.fn.expand('%:p:h')
end

local show_fb = function()
	telescope.extensions.file_browser.file_browser({
		path = '%:p:h',
		cwd = telescope_buffer_dir(),
		respect_gitignore = true,
    		hidden = true,
    		grouped = true,
    		previewer = false,
    		initial_mode = 'normal',
    		layout_config = { height = 40 }
	})
end

vim.keymap.set('n', ';f', find_files)
vim.keymap.set('n', ';r', live_grep)
vim.keymap.set('n', '\\\\', buffers) 
vim.keymap.set('n', ';t', help_tags)
vim.keymap.set('n', ';;', resume)
vim.keymap.set('n', ';e', diagnostics)
vim.keymap.set('n', 'sf', show_fb)
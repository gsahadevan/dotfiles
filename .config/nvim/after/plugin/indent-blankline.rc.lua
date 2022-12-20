local status, blankline = pcall(require, 'indent-blankline')
if (not status) then return end

blankline.setup {
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = true,
	show_end_of_line = true,
	space_char_blankline = " ",
	char = '┊', -- looks cleaner
	-- char = "",
	-- char_highlight_list = {
	-- 	"IndentBlanklineIndent1",
	-- 	"IndentBlanklineIndent2",
	-- 	"IndentBlanklineIndent3",
	-- 	"IndentBlanklineIndent4",
	-- 	"IndentBlanklineIndent5",
	-- 	"IndentBlanklineIndent6",
	-- },
	-- space_char_highlight_list = {
	-- 	"IndentBlanklineIndent1",
	-- 	"IndentBlanklineIndent2",
	-- },
	show_trailing_blankline_indent = false,
}

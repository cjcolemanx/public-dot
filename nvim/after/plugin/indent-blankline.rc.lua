vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

-- local colors = {
--   IndentBlanklineContext = {
--     fg = "#5a93aa",
--   },
-- }

vim.cmd([[highlight IndentBlanklineIndent1 guifg=#03A307 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#73A3B7 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#fda47f gui=nocombine]])
vim.cmd([[highlight IndentBlanklineContextChar cterm=nocombine ctermfg=11 guifg=#5a93aa gui=nocombine]])
vim.cmd([[highlight IndentBlanklineContextStart cterm=underline gui=underline guisp=#5a93aa]])

require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
	},
})
-- 191726

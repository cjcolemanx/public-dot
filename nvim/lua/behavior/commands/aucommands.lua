local mk_group = vim.api.nvim_create_augroup
local mk_aucmd = vim.api.nvim_create_autocmd
local winnr = vim.api.nvim_get_current_win

-- Go to last known location when opening a buffer
vim.cmd([[
autocmd BufReadPost * if line("'\"") > 1 && line("'\'") <= line("$") | execute "normal! g`\"" | endif
]])

-- Make these windows close with 'q'
vim.cmd([[
autocmd FileType help,qf nnoremap <buffer><silent> q :close<CR>
]])

-------------------------
-- => QOL
-------------------------
-- Exit Insert mode after a time
-- vim.api.nvim_create_augroup("AutoExitInsertMode", {})
-- vim.api.nvim_create_autocmd("CursorHoldI", { command = "stopinsert", group = "AutoExitInsertMode" })

-- Highligh yanked text
mk_group("HighlightYank", {})
mk_aucmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 300 })
	end,
	group = "HighlightYank",
})

-- Highlight Line in INSERT
local insert_au = mk_group("HighlightOnInsert", {})
mk_aucmd("InsertEnter", {
	callback = function()
		vim.wo[winnr()].cursorline = true
	end,
	group = insert_au,
})
mk_aucmd("InsertLeave", {
	callback = function()
		vim.wo[winnr()].cursorline = false
	end,
	group = insert_au,
})

-------------------------
-- => Git
-------------------------
local gitcommit_au = mk_group("GitCommit", {})

-- Highlight max width and start in insert mode
mk_aucmd("FileType", {
	pattern = { "gitcommit", "gitrebase" },
	callback = function()
		vim.wo[winnr()].textwidth = 72
		vim.wo[winnr()].colorcolumn = "73"
		vim.cmd("startinsert")
	end,
	group = gitcommit_au,
})

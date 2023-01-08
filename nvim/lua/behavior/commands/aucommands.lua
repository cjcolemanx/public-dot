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
vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", { command = "silent! lu vim.highlight.on_yank()", group = "HighlightYank" })

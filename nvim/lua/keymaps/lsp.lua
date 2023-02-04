local M = {}
local setKey = vim.api.nvim_buf_set_keymap

function M.javascript(bufnr)
	local opts = { silent = true }
	setKey(bufnr, "n", "<Leader>go", ":TSLspOrganize<CR>", opts)
	setKey(bufnr, "n", "<Leader>gr", ":TSLspRenameFile<CR>", opts)
	setKey(bufnr, "n", "<Leader>gi", ":TSLspImportAll<CR>", opts)
end

return M

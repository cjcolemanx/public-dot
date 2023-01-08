-------------------------
-- => Augroups
-------------------------
vim.api.nvim_create_augroup("nvim_tree_auto_maps", { clear = true })

-------------------------
-- => Aucommands
-------------------------
-- Update automaps
vim.api.nvim_create_autocmd("BufEnter", {
	group = "nvim_tree_auto_maps",
	callback = function()
		local bufName = vim.fn.bufname()
		if string.sub(bufName, 1, 8) == "NvimTree" then
			vim.keymap.set("n", "J", "5j", { buffer = true })
			vim.keymap.set("n", "K", "5k", { buffer = true })
		end
	end,
})

-- NOTE: Keymaps exist here

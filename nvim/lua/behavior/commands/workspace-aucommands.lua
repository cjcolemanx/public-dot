-------------------------
-- => Augroups
-------------------------
vim.api.nvim_create_augroup("config_editing", { clear = true })

-------------------------
-- => Aucommands
-------------------------
-- Source init.lua
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "/home/charles/.config/nvim/*",
	group = "config_editing",
	callback = function()
		vim.keymap.set("n", ";R", ":source ~/.config/nvim/init.lua<cr>")
	end,
})

-------------------------
-- => Config
-------------------------

local status, lv = pcall(require, "link-visitor")

if not status then
	return
end

vim.keymap.set("n", "<C-CR>", function()
	lv.link_under_cursor()
end)

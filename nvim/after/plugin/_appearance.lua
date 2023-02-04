local status, nightfox = pcall(require, "nightfox")

if not status then
	print("ERROR: plugin 'nightfox' is unavailable")
	return
end

if vim.colorscheme == "duskfox" then
	nightfox.setup({
		options = {
			styles = { comments = "italic", functions = "italic,bold" },
			transparent = false,
			dim_inactive = true,
			terminal_colors = true,
		},
	})
end

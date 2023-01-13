local status, glow = pcall(require, "glow")
if not status then
	return
end

glow.setup({
	style = "dark",
	width_ratio = 0.5,
	height_ratio = 0.8,
	pager = true,
})

require("keymaps.plugin-maps").glow()

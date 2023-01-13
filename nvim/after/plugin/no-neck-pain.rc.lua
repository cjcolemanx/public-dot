local status, nnp = pcall(require, "no-neck-pain")

if not status then
	return
end

require("keymaps.plugin-maps").noNeckPain()

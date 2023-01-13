local status, harpoon = pcall(require, "harpoon")

if not status then
	return
end

harpoon.setup()

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
require("keymaps.plugin-maps").harpoonMarks(mark, ui)

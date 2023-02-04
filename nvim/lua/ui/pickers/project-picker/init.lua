require("ui.pickers.project-picker.setup")
require("ui.pickers.project-picker.previewer")
require("ui.pickers.project-picker.actions")
require("ui.pickers.project-picker.file-ops")

local function setup(opts)
	local options = {
		-- finder = projects,
	}
end

local picker = require("ui.pickers.project-picker.project-picker")

return picker

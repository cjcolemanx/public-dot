local M = {}

M.borderStyle = {
	{
		top_left = "┏",
		top_center = "─",
		top_right = "┓",
		side_middle = "│",
		bottom_right = "┛",
		bottom_center = "─",
		bottom_left = "┗",
		-- May be redundant, but good for consistency
		side_left = "│",
		side_right = "│",
	},
	{
		top_center = "─",
		top_left = "┌",
		top_right = "┐",
		side_middle = "│",
		side_right = "│",
		side_left = "│",
		bottom_center = "─",
		bottom_right = "┘",
		bottom_left = "└",
		-- side= "│",
	},
}

return M

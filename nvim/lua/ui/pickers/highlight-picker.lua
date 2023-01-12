local status = pcall(require, "telescope")
if not status then
	print("ERROR: nvim-telescope is unavailable for custom pickers")
	return
end

local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-------------------------
-- => Actions
-------------------------
function enter(prompt_bufnr)
	local selection = action_state.get_selected_entry().value
	print(selection)
	actions.close(prompt_bufnr)
	-- FIXME: Broken Logic
	vim.api.nvim_buf_set_keymap(
		0,
		"",
		"9(5)",
		":<c-u>HSHighlight " .. selection .. "<CR>",
		{ silent = true, noremap = true }
	)
	vim.fn.feedkeys("9(5)")
end

-------------------------
-- => Config
-------------------------
local colorTable = require("ui.look.high-str-colors")
local colors = colorTable.get_highlight_colors()
local style_mini = {
	layout_strategy = "horizontal",
	layout_config = {
		prompt_position = "top",
		width = 0.2,
	},
	sorting_strategy = "ascending",
}

local opts = function()
	colors = colorTable.get_highlight_colors()
	return {
		finder = finders.new_table({
			results = colors,
			entry_maker = function(entry)
				return {
					value = entry[1],
					ordinal = entry[2],
					display = entry[2],
				}
			end,
		}),
		prompt_title = "\\ Prompt /",
		results_title = "\\ Highlight /",
		attach_mappings = function(prompt_bufnr, map)
			map("i", "<cr>", enter)
			return true
		end,
	}
end

local highlight_picker = function(_opts)
	pickers.new(style_mini, _opts):find()
end

local function open_highlight_picker()
	highlight_picker(opts())
end

return {
	open = open_highlight_picker,
}

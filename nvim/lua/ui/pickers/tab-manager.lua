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

local keymap_popup = require("ui.popups.telescope-binds")

local tab_funcs = require("behavior.commands.tabs")

local tab_list = {}
local current_focused_buffer
-------------------------
-- => Functions
-------------------------
local setupTabList = function()
	local cur_tab = vim.fn.tabpagenr()
	local all_tabs = vim.fn.gettabinfo()

	local options = tab_funcs.makeTabList(all_tabs, cur_tab)

	return options
end

-------------------------
-- => Actions
-------------------------
local function sendToNewTab(prompt_bufnr)
	keymap_popup.close_telescope_binds_popup()
	actions.close(prompt_bufnr)
	tab_funcs.sendToNewTab(current_focused_buffer)
end

local function sendToNextTab(prompt_bufnr)
	keymap_popup.close_telescope_binds_popup()
	actions.close(prompt_bufnr)
	tab_funcs.sendToNextTab()
end

local function sendToPreviousTab(prompt_bufnr)
	keymap_popup.close_telescope_binds_popup()
	actions.close(prompt_bufnr)
	tab_funcs.sendToPreviousTab()
end

local function sendToChosenTab(prompt_bufnr)
	keymap_popup.close_telescope_binds_popup()
	actions.close(prompt_bufnr)
	local selected = action_state.get_selected_entry().value
	tab_funcs.sendToTab(selected)
end

-------------------------
-- => Config
-------------------------

local style_mini = {
	layout_strategy = "horizontal",
	layout_config = {
		height = 0.2,
		width = 0.3,
		prompt_position = "top",
	},
	sorting_strategy = "ascending",
}

local opts = function()
	tab_list = setupTabList()
	local finder = finders.new_table({
		results = tab_list,
		entry_maker = function(entry)
			return {
				value = entry,
				display = "Tab " .. entry,
				ordinal = entry,
			}
		end,
	})
	return {
		finder = finder,
		-- sorter = sorters.get_generic_fuzzy_sorter({}),
		prompt_title = "\\ Tab Manager /",
		results_title = "\\ Send to Tab #... /",
		attach_mappings = function(prompt_bufnr, map)
			map("i", "<ESC>", function()
				keymap_popup.close_telescope_binds_popup()
				actions.close(prompt_bufnr)
			end)
			map("i", "<cr>", sendToChosenTab)
			map("i", "<C-p>", sendToNextTab)
			map("i", "<C-n>", sendToPreviousTab)
			map("i", "<C-o>", sendToNewTab)
			return true
		end,
	}
end

local keybinds_table = {
	"<CR>    = Move Current Window to Selected Tab",
	"<C-p>   = Move Current Window to Next Tab",
	"<C-n>   = Move Current Window to Previous Tab",
	"<C-o>   = Move Current Window to a New Tab",
}

keymap_popup.add_telescope_binds(keybinds_table, "tab-manager")

local tab_manager = function(opts)
	local cur_buf = vim.fn.bufnr()
	current_focused_buffer = vim.fn.getbufinfo(cur_buf)[1]
	pickers.new(style_mini, opts):find()
end

local function open_tab_manager()
	tab_manager(opts())
	keymap_popup.open_telescope_binds_popup("tab-manager")
end

return {
	open = open_tab_manager,
}

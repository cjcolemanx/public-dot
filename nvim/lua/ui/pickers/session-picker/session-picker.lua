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

local sessions = vim.fn.readdir("/home/charles/.config/nvim/sessions/")
table.insert(sessions, "(new)") -- for new session

-------------------------
-- => Functions
-------------------------
--[[
Updates the cached session values with the `readdir` command.
--]]
local function refresh_cached_sessions()
	sessions = vim.fn.readdir("/home/charles/.config/nvim/sessions/")
	table.insert(sessions, "(new)") -- for new session
end

--[[
Closes keymaps and telescope picker.

prompt_bufnr: (number)
--]]
local function cleanup_action(prompt_bufnr)
	keymap_popup.close_telescope_binds_popup()
	actions.close(prompt_bufnr)
end

-------------------------
-- => Actions
-------------------------
--[[
Create a new session.

Uses either a user-defined value (from prompt) or a default 'session<Y-M-D>.vim' format
for naming the session file

prompt_bufnr: (number)
--]]
local function create_session(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local prompt_text = picker:_get_prompt()

	local new_session_name

	-- Check prompt for user input
	if prompt_text == "" then
		-- Default session name
		new_session_name = vim.fn.strftime("%Y.%m.%d-%T") .. ".vim"
	else
		-- Input exists
		new_session_name = prompt_text .. ".vim"
	end

	-- Ensure NvimTree is Closed
	vim.cmd("NvimTreeClose")

	-- Create new session
	vim.cmd("mks! ~/.config/nvim/sessions/" .. new_session_name)

	-- Close
	cleanup_action(prompt_bufnr)

	-- Refresh
	refresh_cached_sessions()
end

--[[
Either opens a selected session or creates a new one if the prompt doesn't match 
any of the cached sessions.

prompt_bufnr: (number)
--]]
local function enter(prompt_bufnr)
	local selected = action_state.get_selected_entry()

	-- User is hovering a non-existant session or the (new) key
	if selected == nil or selected[1] == "(new)" then
		create_session(prompt_bufnr)
	else
		-- Close
		cleanup_action(prompt_bufnr)

		vim.cmd({ cmd = "source", args = { "~/.config/nvim/sessions/" .. selected[1] } })

		-- Refresh
		refresh_cached_sessions()
	end
end

--[[
Remove a session from storage.

prompt_bufnr: (number)
--]]
local function remove_session(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	vim.cmd("!rm -f ~/.config/nvim/sessions/" .. selected[1])

	-- Refresh
	refresh_cached_sessions()
end

--[[
Overwrite a selected session with a new session. Keeps the same file name.

prompt_bufnr: (number)
--]]
local function overwrite_session(prompt_bufnr)
	local selected = action_state.get_selected_entry()

	-- Overwrite Selected session
	vim.cmd("mks! ~/.config/nvim/sessions/" .. selected[1])

	-- Close
	cleanup_action(prompt_bufnr)

	-- Refresh
	refresh_cached_sessions()
end

--[[
Moves the selected choice forward in the table.

prompt_bufnr: (number)
--]]
local function next_session(prompt_bufnr)
	actions.move_selection_next(prompt_bufnr)
end

--[[
Moves the selected choice backward in the table.

prompt_bufnr: (number)
--]]
local function prev_session(prompt_bufnr)
	actions.move_selection_previous(prompt_bufnr)
end

-------------------------
-- => Config
-------------------------

local style_mini = {
	layout_strategy = "horizontal",
	layout_config = {
		height = 0.5,
		width = 0.3,
		prompt_position = "top",
	},
	sorting_strategy = "ascending",
}

local opts = {
	finder = finders.new_table(sessions),
	sorter = sorters.get_generic_fuzzy_sorter({}),
	promp_title = "\\ Type Session Name /",
	results_title = "\\ Session Picker /",
	attach_mappings = function(prompt_bufnr, map)
		map("i", "<CR>", enter)
		map("i", "<ESC>", function()
			keymap_popup.close_telescope_binds_popup()
			actions.close(prompt_bufnr)
		end)
		map("i", "<C-l>", enter)
		map("i", "<C-j>", next_session)
		map("i", "<C-k>", prev_session)
		map("i", "<C-Space>", create_session)
		map("i", "<C-o>", overwrite_session)
		map("i", "<C-x>", remove_session)
		return true
	end,
}

local keybinds_table = {
	"<CR>   = Open Session",
	"<C-l>  = Open Session",
	"<C-Space>  = Create a New Session",
	"<C-o>  = Overwrite Selected Session",
	"<C-x>  = Delete Selected Session",
	"",
	"---------------------------------",
	"",
	"You can type a new session name and press <CR>",
	"  to create a session with the name you typed.",
	"  This also works with <C-Space>.",
}

keymap_popup.add_telescope_binds(keybinds_table, "session-picker")

local session_picker = pickers.new(style_mini, opts)

--[[
Bundles the `session_picker:find()` call with the keybind popup call.
--]]
local function open_session_picker()
	session_picker:find()
	keymap_popup.open_telescope_binds_popup("session-picker")
end

return { open = open_session_picker }

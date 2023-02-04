local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

local M = {}

local function alert_user(type, data)
	if type == "db_created" then
		require("notify").notify("Created Project Database File", vim.log.levels.SUCCESS)
	end

	print(vim.inspect(data))
end

local function cleanup(prompt_bufnr)
	local db_file = io.open(projects_file, "w")

	if db_file ~= nil then
		for _, v in ipairs(projects) do
			db_file:write(v.project_name .. project_directory_delim .. v.path)
		end
		db_file:close()
	end
end

-- FIXME: Need to declare 'projects_file' and 'porject_directory_delim'
local function add_new_project(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local prompt_text = picker:_get_prompt()
	local directory = vim.fn["getcwd"]()

	-- Prep for write
	local new_project_name

	-- Create new project
	if prompt_text == "" or prompt_text == nil then
		-- Alert User
		require("notify").notify("Project Name Is Required!", vim.log.levels.ERROR, { timeout = 200 })
	else
		print(vim.inspect(prompt_text) .. project_directory_delim .. directory)
		local db_file = io.open(projects_file, "a")

		if db_file ~= nil then
			db_file:write(prompt_text .. project_directory_delim .. directory)
			db_file:close()
		end
	end

	cleanup(prompt_bufnr)
end

-- TODO: Implement
local function remove_project(prompt_bufnr) end

-- TODO: Implement
local function overwrite_project(prompt_bufnr) end

local function next_project(prompt_bufnr)
	actions.move_selection_previous(prompt_bufnr)
end

local function previous_project(prompt_bufnr)
	actions.move_selection_next(prompt_bufnr)
end

local function on_enter(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local name = selected.value.project_name
	local path = selected.value.path

	-- User is hovering a non-existant project or the (new) key
	if selected == nil or name == add_new_prompt then
		add_new_project(prompt_bufnr)
	else
		-- Change Path
		vim.cmd("chdir " .. path)

		-- Close
		cleanup_action(prompt_bufnr)
	end
end

M.add_new_project = add_new_project

return M

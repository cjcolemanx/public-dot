---@diagnostic disable: deprecated
local status = pcall(require, "telescope")
if not status then
	print("ERROR: nvim-telescope is unavailable for custom pickers")
	return
end

local init = require("ui.pickers.project-picker.setup").setup

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local entry_display = pickers.entry_display

local keymap_popup = require("ui.popups.telescope-binds")

local projects_file = vim.fn.stdpath("config") .. "/data/project-locations.txt"

local project_directory_delim = "|"
local add_new_prompt = "(Add New Project)"
local projects = {}

-------------------------
-- => Functions
-------------------------

local function write_to_db()
	local db_file = io.open(projects_file, "w")

	if db_file ~= nil then
		for _, v in ipairs(projects) do
			db_file:write(v.project_name .. project_directory_delim .. v.path)
		end
		db_file:close()
	end
end

local function get_git_status(dir, callback)
	vim.fn.jobstart({ "git", "-C", dir, "status" }, {
		stdout_bufferred = true,
		on_stdout = function(_, data)
			print("Data" .. vim.inspect(data))
			callback(data[1])
		end,
		-- on_stderr = function(_, data)
		-- 	callback("Not a git repository.")
		-- end,
	})
end

-------------------------
-- => Config
-------------------------
-- Prepare Projects
-- FIXME:
-- local projects_raw = vim.fn.readfile(projects_file)
-- for _, v in pairs(projects_raw) do
-- 	local str_arr = {}
-- 	v:gsub("([^|]*)", function(c)
-- 		if c ~= "" then
-- 			table.insert(str_arr, c)
-- 		end
-- 	end)
-- 	-- Name and Location of Project
-- 	local entry = { project_name = str_arr[1], path = str_arr[2] }
-- 	table.insert(projects, entry)
-- end

table.insert(projects, { project_name = add_new_prompt, path = "" }) -- for new project
-- FIXME: Testing
table.insert(projects, { project_name = "Add", path = "/home/charles/.torrents" }) -- for new project

local cwd = vim.fn.getcwd()
local cwd_git = ""

local style_mini = {
	-- layout_strategy = "horizontal",
	layout_strategy = "vertical",
	layout_config = {
		height = 0.4,
		width = 0.3,
		prompt_position = "top",
	},
	sorting_strategy = "ascending",
}
local opts = {
	finder = finders.new_table({
		results = projects,
		entry_maker = function(entry)
			-- FIXME: bad re-renders
			return {
				value = entry,
				-- TODO: make use of global state to find if current selection exists
				display = entry.project_name,
				ordinal = entry.project_name,
			}
		end,
	}),
	sorter = sorters.get_generic_fuzzy_sorter({}),
	prompt_title = "\\ Type Project Name /",
	results_title = "\\ Project Picker /",
	-- previewer = previewer,
	previewer = require("ui.pickers.project-picker.previewer").previewer,
	attach_mappings = function(prompt_bufnr, map)
		map("i", "<CR>", enter)
		map("i", "<ESC>", function()
			keymap_popup.close_telescope_binds_popup()
			actions.close(prompt_bufnr)
		end)
		map("i", "<C-j>", next_project)
		map("i", "<C-k>", prev_project)
		map("i", "<C-Space>", add_new_project)
		-- map("i", "<C-o>", overwrite_session)
		-- map("i", "<C-x>", remove_session)

		-- TODO:
		-- map("i", "<C-e>", edit_project_path)
		-- map("i", "<C-r>", edit_project_name)

		return true
	end,
}

local keybinds_table = {
	"<CR>   = Open Project",
	"<C-e>  = Edit Project Path",
	"<C-Space>  = Add a New Project",
	"<C-r>  = (Not Implemented yet) Rename Project",
	"<C-o>  = (Not Implemented yet) Overwrite Selected Project",
	"<C-x>  = (Not Implemented yet) Remove Selected Project",
	"",
	"---------------------------------",
	"",
	"Don't forget to refresh NvimTree!",
	"",
	"You can type a new project name and press <CR>",
	"  to create a project with the name you typed.",
	"  This also works with <C-Space>.",
}

keymap_popup.add_telescope_binds(keybinds_table, "project-picker")

local session_picker = pickers.new(style_mini, opts)

local function open_project_picker()
	session_picker:find()
	keymap_popup.open_telescope_binds_popup("project-picker")
end

return { open = open_project_picker, setup = init }

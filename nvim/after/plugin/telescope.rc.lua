local status, telescope = pcall(require, "telescope")

if not status then
	-- print("ERROR: plugin 'Telescope' is unavailable")
	return
end

-- Instantiate Custom Pickers
require("ui.pickers").bind_pickers()

local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions
local builtin = require("telescope.builtin")
local utils = require("telescope.utils")
local previewers = require("telescope.previewers")

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

local maps = require("keymaps.plugin-maps").telescope_setup_mappings(actions)

telescope.setup({
	defaults = {
		mappings = maps.defaults.mappings,
	},
	pickers = {
		help_tags = {
			mappings = maps.pickers.help_tags.mappings,
		},
		man_pages = {
			mappings = maps.pickers.man_pages.mappings,
		},
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			hijack_netrw = true,
			mappings = maps.extensions.file_browser.mappings,
		},
		project = {
			base_dirs = {},
			hidden_files = false, -- default: false
			order_by = "desc", -- recent (default), asc, desc
			sync_with_nvim_tree = false, -- default: false
		},
		media_files = {
			filetypes = {
				"png",
				"jpg",
			},
			find_cmd = "rg",
		},
		refactoring = {},
		undo = {
			side_by_side = true,
			layout_strategy = "vertical",
			layout_config = {
				preview_height = 0.8,
			},
		},
	},
})

-- Load Extensions and Options
telescope.load_extension("file_browser")
telescope.load_extension("project")
telescope.load_extension("media_files")
telescope.load_extension("refactoring")
telescope.load_extension("harpoon")
telescope.load_extension("undo")

-- Add keybinds
require("keymaps.plugin-maps").telescope_binds(builtin, utils, previewers)

-- telescope.load_extension("xray23")

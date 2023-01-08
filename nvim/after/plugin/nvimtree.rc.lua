local status, nvimTree = pcall(require, "nvim-tree")
if not status then
	-- print("ERROR: plugin 'nvim-tree' is unavailable")
	return
end

-- Helpers
local helpers_status, helpers = pcall(require, "behavior.functions.nvim-tree")
if not helpers_status then
	-- print("ERROR: import 'helpers' in 'nvim-tree' is unavailable")
	-- print(helpers)
	return
end

nvimTree.setup({
	open_on_setup = false, -- open when you open nvim in a directory (but no specific file)
	ignore_buffer_on_setup = true,
	ignore_ft_on_setup = {
		"gitcommit",
	},
	respect_buf_cwd = true, -- ??? FIXME
	diagnostics = { enable = true },
	view = {
		side = "right",
		number = true,
		relativenumber = true,
		signcolumn = "yes",
		adaptive_size = true, -- fit filename
		mappings = require("keymaps.plugin-maps").nvimTree(helpers),
	},
	renderer = {
		highlight_opened_files = "all",
		indent_markers = { enable = true },
	},
	actions = {
		change_dir = {
			enable = true,
			global = true,
		},
		open_file = {
			quit_on_open = false,
			window_picker = {
				chars = "ASDFGQWERT",
			},
		},
	},
	filters = {}, -- TODO
	disable_netrw = true, -- Fix race conditions w/ netrw
	tab = {
		sync = {
			open = true,
			close = true,
		},
	},
	notify = {
		threshold = 3,
	},
	trash = {
		require_confirm = true,
	},
})

-- Setup Keybinds
require("keymaps.plugin-maps").nvimTree_binds()

-- view.mappings.list = { -- BEGIN_DEFAULT_MAPPINGS
--   { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
--   { key = "<C-e>",                          action = "edit_in_place" },
--   { key = "O",                              action = "edit_no_picker" },
--   { key = { "<C-]>", "<2-RightMouse>" },    action = "cd" },
--   { key = "<C-v>",                          action = "vsplit" },
--   { key = "<C-x>",                          action = "split" },
--   { key = "<C-t>",                          action = "tabnew" },
--   { key = "<",                              action = "prev_sibling" },
--   { key = ">",                              action = "next_sibling" },
--   { key = "P",                              action = "parent_node" },
--   { key = "<BS>",                           action = "close_node" },
--   { key = "<Tab>",                          action = "preview" },
--   { key = "K",                              action = "first_sibling" },
--   { key = "J",                              action = "last_sibling" },
--   { key = "I",                              action = "toggle_git_ignored" },
--   { key = "H",                              action = "toggle_dotfiles" },
--   { key = "U",                              action = "toggle_custom" },
--   { key = "R",                              action = "refresh" },
--   { key = "a",                              action = "create" },
--   { key = "d",                              action = "remove" },
--   { key = "D",                              action = "trash" },
--   { key = "r",                              action = "rename" },
--   { key = "<C-r>",                          action = "full_rename" },
--   { key = "x",                              action = "cut" },
--   { key = "c",                              action = "copy" },
--   { key = "p",                              action = "paste" },
--   { key = "y",                              action = "copy_name" },
--   { key = "Y",                              action = "copy_path" },
--   { key = "gy",                             action = "copy_absolute_path" },
--   { key = "[e",                             action = "prev_diag_item" },
--   { key = "[c",                             action = "prev_git_item" },
--   { key = "]e",                             action = "next_diag_item" },
--   { key = "]c",                             action = "next_git_item" },
--   { key = "-",                              action = "dir_up" },
--   { key = "s",                              action = "system_open" },
--   { key = "f",                              action = "live_filter" },
--   { key = "F",                              action = "clear_live_filter" },
--   { key = "q",                              action = "close" },
--   { key = "W",                              action = "collapse_all" },
--   { key = "E",                              action = "expand_all" },
--   { key = "S",                              action = "search_node" },
--   { key = ".",                              action = "run_file_command" },
--   { key = "<C-k>",                          action = "toggle_file_info" },
--   { key = "g?",                             action = "toggle_help" },
--   { key = "m",                              action = "toggle_mark" },
--   { key = "bmv",                            action = "bulk_move" },
-- } -- END_DEFAULT_MAPPINGS

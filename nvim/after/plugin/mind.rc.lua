local status, mind = pcall(require, "mind")

if not status then
	return
end

mind.setup({
	persistence = {
		-- TODO: Extract to environment variable
		data_dir = "/mnt/A/notes/mind-nvim/data",
	},
	ui = {
		icon_preset = {
			{ " ", "Sub-project" },
			{ " ", "Journal, newspaper, weekly and daily news" },
			{ " ", "For when you have an idea" },
			{ " ", "Note taking?" },
			{ "陼", "Task management" },
			{ " ", "Uncheck, empty square or backlog" },
			{ " ", "Full square or on-going" },
			{ " ", "Check or done" },
			{ " ", "Trash bin, deleted, cancelled, etc." },
			{ " ", "GitHub" },
			{ " ", "Monitoring" },
			{ " ", "Internet, Earth, everyone!" },
			{ " ", "Frozen, on-hold" },
		},
	},
	keymaps = {
		normal = {
			["<cr>"] = "open_data",
			["<s-cr>"] = "open_data_index",
			l = "toggle_node",
			h = "toggle_node",
			["<s-tab>"] = "toggle_node",
			["/"] = "select_path",
			["$"] = "change_icon_menu",
			-- c = "add_inside_end_index",
			A = "add_inside_start",
			a = "add_inside_end",
			c = "copy_node_link",
			C = "copy_node_link_index",
			d = "delete",
			D = "delete_file",
			n = "add_above",
			p = "add_below",
			q = "quit",
			r = "rename",
			R = "change_icon",
			u = "make_url",
			x = "select",
		},
		selection = {
			["<cr>"] = "open_data",
			["<s-tab>"] = "toggle_node",
			["/"] = "select_path",
			I = "move_inside_start",
			i = "move_inside_end",
			["<C-k>"] = "move_above",
			["<C-j>"] = "move_below",
			q = "quit",
			x = "select",
		},
	},
})

require("keymaps.plugin-maps").mind(mind)

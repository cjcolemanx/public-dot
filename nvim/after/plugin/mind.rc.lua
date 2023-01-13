local status, mind = pcall(require, "mind")
local status_maps, map = pcall(require, "keymaps.plugin-maps")

if not status or not status_maps then
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
			{ " ", "Reminder, Time-Sensitive, Nebulous" },
			{ " ", "Priority Low" },
			{ " ", "Priority Mid" },
			{ " ", "Priority High" },
		},
	},
	keymaps = map.MindMaps,
})

-- require("keymaps.plugin-maps").mind(mind)
map.mind(mind)

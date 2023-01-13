local status, legendary = pcall(require, "legendary")

if not status then
	return
end

local keymaps = {}
local functions = {}
local commands = {}
local autocommands = {}

local my_plugin_maps = require("keymaps.plugin-maps").legend
local my_global_maps = require("keymaps.global-map-legend").legend
local my_picker_maps = require("ui.pickers").legend

local call_legendary = {
	{
		";lk",
		"<CMD>Legendary keys<CR>",
		description = "Legendary: Show Keymaps",
		opts = { silent = true },
	},
	{
		";lc",
		"<CMD>Legendary commands<CR>",
		description = "Legendary: Show Commands",
		opts = { silent = true },
	},
	{
		";lf",
		"<CMD>Legendary functions<CR>",
		description = "Legendary: Show Functions",
		opts = { silent = true },
	},
	{
		";la",
		"<CMD>Legendary autocmds<CR>",
		description = "Legendary: Show Autocommands",
		opts = { silent = true },
	},
}

for _, v in ipairs(my_plugin_maps) do
	table.insert(keymaps, v)
end
for _, v in ipairs(my_global_maps) do
	table.insert(keymaps, v)
end
for _, v in ipairs(my_picker_maps) do
	table.insert(keymaps, v)
end
for _, v in ipairs(call_legendary) do
	table.insert(keymaps, v)
end

legendary.setup({
	keymaps = keymaps,
})

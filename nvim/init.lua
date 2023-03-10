vim.g.my_agenda_dir = "/mnt/A/notes/personal/agenda"
vim.g.my_temporal_notes_dir = "/mnt/A/notes/personal/temporal"

if vim.g.startenv == nil then
	vim.g.startenv = "base"
end
if vim.g.vscode then
	require("vscode")
else
	require("plugin")
	require("behavior.global")
	require("behavior.commands.workspace-aucommands")
	require("behavior.commands.aucommands")
	require("keymaps.global-maps")
	require("keymaps.filetype")
	require("ui.look")
end

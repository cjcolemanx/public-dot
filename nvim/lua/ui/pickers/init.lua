local M = {}

function M.bind_pickers(msg)
	local p_picker = require("ui.pickers.project-picker")
	p_picker.setup()
	vim.keymap.set("n", ";<space>s", function()
		require("ui.pickers.session-picker").open()
	end)
	vim.keymap.set("n", ";<space>j", function()
		require("ui.pickers.journal-picker").open()
	end)
	vim.keymap.set("v", ";<space>hl", function()
		require("ui.pickers.highlight-picker").open()
	end)
	vim.keymap.set("n", ";<space>c", function()
		require("ui.pickers.config-picker").open()
	end)
	vim.keymap.set("n", ";<space>t", function()
		require("ui.pickers.tab-manager").open()
		-- if tab_list[1] == nil then
		--   open_tab_manager()
		-- else
		--   require("notify").notify("No Tabs to Manage!", vim.log.levels.DEBUG, { title = "tab-manager" })
		-- end
	end)
	-- FIXME: issues with git status and multiple jobs
	vim.keymap.set("n", ";<space>p", function()
		-- require("ui.pickers.project-picker").open()
		-- p_picker.open()
	end)
end

local legend = {
	{ ";<Space>s", description = "Custom Telescope: Session Picker" },
	{ ";<Space>j", description = "Custom Telescope: Journal Picker (WIP)" },
	{ ";<Space>hl", description = "Custom Telescope: Highlight Picker (Search Highlight groups)" },
	{ ";<Space>c", description = "Custom Telescope: Config File Picker" },
	-- { ";<Space>p", description = "Custom Telescope: Project Picker" },
	{ ";<Space>t", description = "Custom Telescope: Tab Manager" },
}

M.legend = legend

return M

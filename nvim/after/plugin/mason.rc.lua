local status1, mason = pcall(require, "mason")
if not status1 then
	-- print("ERROR: plugin 'mason' is unavailable")
	return
end

-- TODO: Move keymaps to keymaps.plugin-keymaps

local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	-- print("ERROR: plugin 'mason-lspconfig' is unavailable")
	return
end

mason.setup({
	check_outdated_packages_on_open = true,
	border = "single",
	icons = {
		package_installed = " ✓ ",
		package_pending = " ➜ ",
		package_uninstalled = " ✗ ",
	},
	keymaps = {
		toggle_package_expand = "<CR>",
		install_package = "i",
		update_package = "u",
		check_package_version = "c",
		update_all_packages = "U",
		check_outdated_packages = "C",
		uninstall_package = "X",
		cancel_installation = "<C-c>",
		apply_langauge_filter = "<C-f>",
	},
	-- NOTE - below isn't working?
	-- install_root_dir = '$(vim.fn.stdpath)/data/mason',
	-- pip = {},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
	-- github = {},
})

mason_lspconfig.setup({
	ensure_installed = require("lsp.sources"),
	automatic_installation = true,
})

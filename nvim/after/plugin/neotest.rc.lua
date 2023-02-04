local status, nt = pcall(require, "neotest")

if not status then
	return
end

nt.setup({
	adapters = {
		require("neotest-python")({}),
		require("neotest-jest")({}),
		require("neotest-rust")({}),
		require("neotest-plenary")({}),

		-- for testrunners w/o adapters
		require("neotest-vim-test")({
			ignore_filetypes = { "python", "typescriptreact", "javascriptreact", "vim", "lua" },
		}),
	},
})

require("keymaps.plugin-maps").neotest(nt)

local status, nt = pcall(require, "neotest")

if not status then
	return
end

nt.setup({
	adapters = {
		require("neotest-python")({}),
		require("neotest-jest")({}),
		-- require("neotest-rust")({}),
		-- require("neotest-plenary")({}),

		-- for testrunners w/o adapters
		require("neotest-vim-test")({}),
	},
	library = {
		plugins = {
			"neotest",
		},
		types = true,
	},
})

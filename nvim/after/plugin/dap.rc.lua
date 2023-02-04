local status, dap = pcall(require, "dap")
local status_2, ui = pcall(require, "dapui")

if not status or not status_2 then
	return
end

ui.setup()
-- ui.setup({
-- 	icons = { expanded = "", collapsed = "", current_frame = "" },
-- 	mappings = {
-- 		-- Use a table to apply multiple mappings
-- 		expand = { "<CR>", "<2-LeftMouse>" },
-- 		open = "o",
-- 		remove = "d",
-- 		edit = "e",
-- 		repl = "r",
-- 		toggle = "t",
-- 	},
-- 	-- Use this to override mappings for specific elements
-- 	element_mappings = {
-- 		-- Example:
-- 		-- stacks = {
-- 		--   open = "<CR>",
-- 		--   expand = "o",
-- 		-- }
-- 	},
-- 	-- Expand lines larger than the window
-- 	-- Requires >= 0.7
-- 	expand_lines = vim.fn.has("nvim-0.7") == 1,
-- 	-- Layouts define sections of the screen to place windows.
-- 	-- The position can be "left", "right", "top" or "bottom".
-- 	-- The size specifies the height/width depending on position. It can be an Int
-- 	-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
-- 	-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
-- 	-- Elements are the elements shown in the layout (in order).
-- 	-- Layouts are opened in order so that earlier layouts take priority in window sizing.
-- 	layouts = {
-- 		{
-- 			elements = {
-- 				-- Elements can be strings or table with id and size keys.
-- 				{ id = "scopes", size = 0.25 },
-- 				"breakpoints",
-- 				"stacks",
-- 				"watches",
-- 			},
-- 			size = 40, -- 40 columns
-- 			position = "left",
-- 		},
-- 		{
-- 			elements = {
-- 				"repl",
-- 				"console",
-- 			},
-- 			size = 0.25, -- 25% of total lines
-- 			position = "bottom",
-- 		},
-- 	},
-- 	controls = {
-- 		-- Requires Neovim nightly (or 0.8 when released)
-- 		enabled = true,
-- 		-- Display controls in this element
-- 		element = "repl",
-- 		icons = {
-- 			pause = "",
-- 			play = "",
-- 			step_into = "",
-- 			step_over = "",
-- 			step_out = "",
-- 			step_back = "",
-- 			run_last = "",
-- 			terminate = "",
-- 		},
-- 	},
-- 	floating = {
-- 		max_height = nil, -- These can be integers or a float between 0 and 1.
-- 		max_width = nil, -- Floats will be treated as percentage of your screen.
-- 		border = "single", -- Border style. Can be "single", "double" or "rounded"
-- 		mappings = {
-- 			close = { "q", "<Esc>" },
-- 		},
-- 	},
-- 	windows = { indent = 1 },
-- 	render = {
-- 		max_type_length = nil, -- Can be integer or nil.
-- 		max_value_lines = 100, -- Can be integer or nil.
-- 	},
-- })

-- Stolen config from https://github.com/mfussenegger/nvim-dap/discussions/355#discussioncomment-2159022
vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointRejected",
	{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapLogPoint",
	{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

require("keymaps.plugin-maps").dap(dap, ui)

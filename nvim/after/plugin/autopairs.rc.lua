local status, autopairs = pcall(require, "nvim-autopairs")

if not status then
	-- print("ERROR: plugin 'nvim-autopairs' is unavailable")
	return
end

autopairs.setup({})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

if cmp and cmp_autopairs then
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

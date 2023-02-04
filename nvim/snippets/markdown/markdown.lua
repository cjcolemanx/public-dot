-- Get Helpers
-- local myFuncs = require("functions.markdown-functions")

local status, myUtility = pcall(require, "behavior.utility.popups")

if not status then
	print("ERROR: myUtility is unavailable")
end

local popups = myUtility.popups
local popup_helpers = myUtility.popup_helpers

-- for _, popup in pairs(popups) do
--   print(popup)
--   for _, i in pairs(popup) do
--     print(i)
--   end
-- end

local ls = require("luasnip")
local s = ls.s --> sinppet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local events = require("luasnip.util.events")

local snippets, autosnippets = {}, {}

-- local file_pattern = "*.md"

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = true }
local group = augroup("Markdown Snippets", { clear = true })
-- local group = vim.api.nvim_create_augroup("Markdown Snippets", { clear = true })

-- Helpers
local cs = function(trigger, nodes, keymap)
	local snippet = s(trigger, nodes)
	table.insert(snippets, snippet)

	if keymap ~= nil then
		local pattern = "*.md"

		-- if type(keymap) == "table" then
		--   pattern = keymap[1]
		--   keymap = keymap[2]
		-- end

		autocmd("BufEnter", {
			pattern = pattern,
			group = group,
			callback = function()
				map({ "i" }, keymap, function()
					ls.snip_expand(snippet)
				end, opts)
			end,
		})
	end
end

local popup = {}

local createPopup = function(args, parent, user_args)
	local p = popups.messagePopUp("hello")

	return ""
end

local removePopup = function()
	-- TODO: Implement
end

local clearPopups = function()
	-- TODO: Implement
end

-------------------------
-- Snippets
-------------------------

local md_date = s(
	";date",
	fmt([[{}]], {
		-- c(2, { t(""), i(1, "function_args") }),
		c(1, {
			-- i(1, os.date("%Y-%m-%d")),
			-- i(1, "today"),
			t(os.date("%Y-%m-%d")),
			t(os.date("%A %d, %b %Y")),
			t(os.date("%Y-%m-%d : %A %d, %b %Y")),
		}),
	})
)

local md_today = s(
	";today",
	fmt(
		[[
  {}
  ]],
		{
			c(1, {
				i(1, os.date("%d")),
				i(1, os.date("%A")),
			}),
		}
	)
)

local md_todo = s(
	"TODO",
	fmt(
		[[
    - [ ] TODO: {}
  ]],
		{
			i(1, "description"),
		}
	)
)

local md_tasklist = s(
	{ trig = ";task%d", regTrig = true },
	fmt(
		[[
    - [ ] {}
  ]],
		{
			i(1, "description"),
		}
	)
)

local md_table = s(
	-- FIXME:
	-- { trig = ";table%d", regTrig = true },
	";table",
	fmt(
		[[
  | {} | {} |
  |----|----|
  | {} | {} |
  ]],
		{
			i(1, "$COL_NAME"),
			-- f(createPopup, { 1 }),
			i(2, "$COL_NAME"),
			i(3, "$COL_VALUE"),
			i(4, "$COL_VALUE"),
		}
	),
	{
		callbacks = {
			[1] = {
				[events.enter] = function(node, _event_args)
					popups.messagePopUp("1")
					createPopup(node)
				end,
			},
			[2] = {
				[events.enter] = function(node, _event_args)
					popups.messagePopUp("2")
				end,
			},
			-- [3] = {
			--   [events.enter] = function(node, _event_args)
			--     popups.messagePopUp("3")
			--   end,
			-- },
			-- [4] = {
			--   [events.enter] = function(node, _event_args)
			--     popups.messagePopUp("4")
			--   end,
			-- },
		},
	}
)

local md_header_1 = s(
	";h1",
	fmt(
		[[
# {}
]],
		{ i(1, "$HEADING") }
	)
)
local md_header_2 = s(
	";h2",
	fmt(
		[[
## {}
]],
		{ i(1, "$HEADING") }
	)
)
local md_header_3 = s(
	";h3",
	fmt(
		[[
### {}
]],
		{ i(1, "$HEADING") }
	)
)
local md_header_4 = s(
	";h4",
	fmt(
		[[
#### {}
]],
		{ i(1, "$HEADING") }
	)
)
local md_header_5 = s(
	";h5",
	fmt(
		[[
##### {}
]],
		{ i(1, "$HEADING") }
	)
)
local md_header_6 = s(
	";h6",
	fmt(
		[[
###### {}
]],
		{ i(1, "$HEADING") }
	)
)

-- Auto Snippets --
table.insert(autosnippets, md_date)
table.insert(autosnippets, md_today)
table.insert(autosnippets, md_todo)
table.insert(autosnippets, md_table)
table.insert(autosnippets, md_header_1)
table.insert(autosnippets, md_header_2)
table.insert(autosnippets, md_header_3)
table.insert(autosnippets, md_header_4)
table.insert(autosnippets, md_header_5)
table.insert(autosnippets, md_header_6)

return snippets, autosnippets

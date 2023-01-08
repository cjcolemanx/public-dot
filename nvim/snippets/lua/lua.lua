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

local snippets, autosnippets = {}, {}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = false })
local file_pattern = "*.lua"

-- Snippet Definitions --

-- NOTE: trying something out
local lua_comment_placeholder = {
	i(1, "-- TODO: Implement"),
	i(1, "-- NOTE: Psuedo Code"),
	i(1, ""),
}

local lua_function_definitions = {
	l_f = { t("local function "), i(1, "$NAME"), t("("), i(2, "$ARGS"), t(")") },
	c_f = { t("local "), i(1, "$NAME"), t(" = function ("), i(2, "$args"), t(")") },
	a_f = { t("function("), i(1, "$ARGS"), t(")") },
}

local lua_function = s(
	{
		trig = "function",
		name = "Lua Function Snippet",
		dscr = {
			"snippets/lua/lua.lua",
			"",
			"3 types:",
		},
		docstring = {
			"-- TYPE A",
			"local function $NAME($ARGS)",
			"  $COMMENT_OR_NOTE",
			"end",
			"",
			"-- TYPE B",
			"function $NAME($ARGS)",
			"  $COMMENT_OR_NOTE",
			"end",
			"",
			"-- TYPE C",
			"local $NAME = function ($ARGS)",
			"  $COMMENT_OR_NOTE",
			"end",
		},
	},
	fmt(
		[[
  {}
    {}
  end
  ]],
		{
			c(1, {
				sn(1, lua_function_definitions.l_f),
				sn(1, lua_function_definitions.a_f),
				sn(1, lua_function_definitions.c_f),
			}),
			c(2, lua_comment_placeholder),
		}
	)
)

local lua_table_insert = s("table insert", fmt([[table.insert({},{})]], { i(1, "$TABLE"), i(2, "$VALUE") }))

-- FIXME:
-- local lua_if = s(
--   "if",
--   fmt(
--     [[
--     if {} {} then
--       {}
--     end
--   ]] ,
--     {
--       -- c(1, {
--       --   c(1, {
--       --     t("opt_1"),
--       --     t("opt_2"),
--       --   }),
--       --   i("var_1"),
--       --   t("not"),
--       -- }),
--       -- c(1, { i(1, "var_1"), t(""), t("not") }),
--       -- c(2, { i(1, "var_2"), t("") }),
--       -- i(3, "-- TODO: Implement"),
--       c()
--     }
--   )
-- )

local lua_local = s(
	"local",
	fmt(
		[[
    local {} = {}
  ]],
		{
			i(1, "$name"),
			i(2, "$value"),
		}
	)
)

local status_call = s(
	"status require",
	fmt(
		[[
    local status, {} = pcall(require, '{}')
    if not status then
      {}
    end
  ]],
		{
			i(1, "package_name"),
			i(2, "package_name"),
			i(3, "-- TODO: do something"),
		}
	)
)

local lua_for_pairs = s(
	"for pairs",
	fmt(
		[[
  for _, {} in {}({}) do
    {}
  end
]],
		{
			i(1, "$id"),
			c(2, { t("pairs"), t("ipairs") }),
			i(3, "$table"),
			i(4, "-- TODO: implementation"),
		}
	)
)

local lua_print_opts = {
	i(1, ""),
	{ t("vim.inspect("), i(1, ""), t(")") },
}

local lua_print = s(
	"print",
	fmt(
		[[
  {}
  print({})
  ]],
		{
			i(1, "-- FIXME: Temporary Print Statement"),
			c(2, lua_print_opts),
		}
	)
)

-- Meta (woah...)

local lua_snip = s(
	";sn",
	fmt(
		[[
    fmt({}
      {}
    {}, {{
      {}
    }})
  ]],
		{
			t("[["),
			i(1, "-- TODO: Snipppet Definition"),
			t("]]"),
			i(2, "-- TODO: Snippet Behavior"),
		}
	)
)

local lua_boiler = s(
	";boilerplate",
	fmt(
		[[
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

    local snippets, autosnippets = {{}}, {{}}

    local group = vim.api.nvim_create_augroup("All Snippets", {{ clear = true }})
    local file_pattern = "*.lua"

    -------------------------
    -- Helpers
    -------------------------
    -------------------------
    -- Snippet Definitions
    -------------------------
    -------------------------
    -- Setup
    -------------------------

    -- Snippets

    -- Autosnippets

    return snippets, autosnippets
  ]],
		{}
	)
)

-- Comments

local lua_comment_header = s(
	";chead",
	fmt(
		[[
-------------------------
-- => {}
-------------------------
  ]],
		{
			i(1, "$HEADER"),
		}
	)
)

local lua_comment_date = s(
	";ctime",
	fmt([[-- {} {}]], {
		c(1, {
			t("$PREFIX"),
			t("created_on:"),
			t("last_update:"),
		}),
		c(2, {
			t(os.date("%Y-%m-%d : %H:%M %p")),
			t(os.date("%A %d, %b %Y : %H:%M %p")),
			t(os.date("%Y-%m-%d - %A %d, %b %Y : %H:%M %p")),
		}),
	})
)

-- local lua_todo = s(";todo", t("TODO: "))
local lua_fixme = s(";fixme", t("FIXME: "))
local lua_note = s("NOTE: ", t("NOTE: "))
local lua_hack = s("hack", t("HACK: "))
local lua_warn = s("WARN", t("WARN: "))
local lua_perf = s("PERF", t("PERF: "))
local lua_test = s("TEST", t("TEST: "))
local lua_functino = s("functino", t("function"))
local lua_selectino = s("selectino", t("selection"))

-- Other

local lua_date = s(
	";date",
	fmt([[{}]], {
		c(1, {
			t(os.date("%Y-%m-%d")),
			t(os.date("%A %d, %b %Y")),
			t(os.date("%Y-%m-%d : %A %d, %b %Y")),
		}),
	})
)

-- Snippets
-- table.insert(snippets, function_no_args)
table.insert(snippets, lua_function)
table.insert(snippets, lua_table_insert)
table.insert(snippets, status_call)
-- table.insert(snippets, lua_if)
table.insert(snippets, lua_local)
table.insert(snippets, lua_print)
table.insert(snippets, lua_for_pairs)

-- Auto Snippets
table.insert(autosnippets, lua_comment_header)
table.insert(autosnippets, lua_comment_date)
table.insert(autosnippets, lua_snip)
table.insert(autosnippets, lua_boiler)
-- table.insert(autosnippets, lua_todo)
table.insert(autosnippets, lua_fixme)
table.insert(autosnippets, lua_note)
table.insert(autosnippets, lua_hack)
table.insert(autosnippets, lua_warn)
table.insert(autosnippets, lua_perf)
table.insert(autosnippets, lua_test)
table.insert(autosnippets, lua_date)
table.insert(autosnippets, lua_functino)
table.insert(autosnippets, lua_selectino)

return snippets, autosnippets

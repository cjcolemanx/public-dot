local builder = require("behavior.utility.snippets")

local ls = require("luasnip")

local i = ls.i --> insert node
local t = ls.t --> text node
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

-------------------------
-- Setup
-------------------------

builder.init_snippets({
  pattern = "*.lua",
  group = "Lua Snippets Decisions Autogroup",
})

-------------------------
-- Snippets
-------------------------
local lua_comment_placeholder = {
  i(1, "-- TODO: Implement"),
  i(1, "-- NOTE: Psuedo Code"),
  i(1, ""),
}

local lua_if_statements = {
  {
    t("if "),
    i(1, "$COND_1"),
    t({ " then ", "  " }),
    c(2, lua_comment_placeholder),
    t({ "", "end" }),
  },
}

local lua_for_statements = {
  {
    t("for _, "),
    i(1, "$ITEM"),
    t("in "),
    c(2, { t("pairs"), t("ipairs") }),
    t("("),
    i(3, "$TABLE"),
    t(") do", ""),
    c(4, lua_comment_placeholder),
    t("", "end"),
  },
}

-- TODO: Documentation
builder.cs({ trig = "if", name = "Lua If Statement" }, fmt([[{}]], { c(1, lua_if_statements) }), { keys = ";if" })
builder.cs({ trig = "for", name = "Lua For Loops" }, fmt([[{}]], { c(1, lua_for_statements) }), { keys = ";for" })

return builder.snippets, autosnippets

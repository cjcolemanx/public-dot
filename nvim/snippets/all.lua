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

-- quick fix (typos)
local mistype_function = s("functino", t("function"))
local mistype_selection = s("selectino", t("selection"))

table.insert(autosnippets, mistype_function)
table.insert(autosnippets, mistype_selection)

return snippets, autosnippets

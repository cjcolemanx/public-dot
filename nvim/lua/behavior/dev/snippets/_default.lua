local M = {}

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

local group = vim.api.nvim_create_augroup("Javascript Snippets", { clear = true })

-------------------------
-- Helpers
-------------------------

-------------------------
-- Snippet Definitions
-------------------------
-- local function lua_print(trigger)
--   return s(
--     trigger,
--   -- TODO: Create Snippet
--   )
-- end

-------------------------
-- Builder
-------------------------

local function tableBuilder(snippets, autosnippets)
	-- table.insert(snippets, react_useEffect("uf"))
	-- table.insert(autosnippets, react_useEffect(";uf"))
end

M.tableBuilder = tableBuilder

return M

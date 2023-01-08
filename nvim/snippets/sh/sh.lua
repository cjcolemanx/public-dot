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

local group = vim.api.nvim_create_augroup("All Snippets", { clear = true })
local file_pattern = "*.lua"

-------------------------
-- Helpers
-------------------------
-------------------------
-- Snippet Definitions
-------------------------
local sh_comment = function(trigger)
  return s(
    trigger,
    fmt(
      [[
####################
## {}
####################
  ]]   ,
      { i(1, "$HEADER") }
    )
  )
end

-------------------------
-- Setup
-------------------------

-- Snippets
table.insert(snippets, sh_comment("chead"))

-- Autosnippets
table.insert(autosnippets, sh_comment(";chead"))

return snippets, autosnippets

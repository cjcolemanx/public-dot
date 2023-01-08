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
  group = "Lua Snippets Module Autogroup",
})

-------------------------
-- Snippets
-------------------------

local lua_comment_placeholder = {
  i(1, "-- TODO: Implement"),
  i(1, "-- NOTE: Psuedo Code"),
  i(1, ""),
}

local lua_module_definitions = {
  -- TODO: Convert to dynamic
  -- {
  --   t({ "local function "}),
  --   i(1, "$FUNC"),
  --   t(" = function("),
  --   i(2, "$ARGS"),
  --   t({ ")", "" }),
  --   c(3, lua_comment_placeholder),
  --   t({ "", "end", "", "return M" }),
  -- },
  -- sn(nil, {
  --   t({ "local M = {}", "", "M." }),
  --   i(1, "$FUNC"),
  --   t(" = function("),
  --   i(2, "$ARGS"),
  --   t({ ")", "" }),
  --   c(3, lua_comment_placeholder),
  --   t({ "", "end", "", "return M" }),
  -- }),
  sn(nil, {
    t({ "local M = {}", "" }),
    c(1, lua_comment_placeholder),
    t({ "", "M." }),
    i(2, "$OBJECT"),
    t(" = {"),
    i(3, "$VALUES"),
    t({ "}", "" }),
    t({ "", "return M" }),
  }),
}

builder.cs(
  {
    trig = "module",
    name = "Lua Module Snippet",
    dscr = {
      "snippets/lua/modules.lua",
      "",
      "Format:",
    },
    docstring = {
      "-- [[ Type 1 - ;moda ]]",
      "local M = {}",
      "",
      "M.$FUNC = function($ARGS)",
      "-- TODO: Implement",
      "end",
      "",
      "return M",
      "",
      "-- [[ Type 2 - ;modb ]]",
      "local function $FUNC()",
      "-- TODO: Implement",
      "end",
      "",
      "return {",
      "  $FUNC = $FUNC",
      "}",
    },
  },
  fmt([[{}]], {
    c(1, lua_module_definitions),
  }),
  { keys = ";mod" }
)

return builder.snippets, autosnippets

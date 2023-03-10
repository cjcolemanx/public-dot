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

local lua_doc = s(
  {
    trig = ";doc",
    name = "Lua Documentation Snippet",
    dscr = {
      "snippets/lua/documentation.lua",
      "",
      "Integrates with treesitter/LSP",
      "",
      "Format:",
    },
    docstring = {
      "--[[",
      "$DESC",
      "",
      "$PARAMS",
      "--]]",
    },
  },
  fmt(
    [[
  --{}
  {}

  {}
  --{}
  ]] ,
    { t("[["), i(1, "$DESC"), i(2, "$PARAMS"), t("]]") }
  )
)

table.insert(autosnippets, lua_doc)

return snippets, autosnippets

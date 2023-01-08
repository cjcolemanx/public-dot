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

local group = vim.api.nvim_create_augroup("Javascript Snippets", { clear = true })
local file_pattern = "*.js"

-------------------------
-- Helpers
-------------------------
-------------------------
-- Snippet Definitions
-------------------------

-- JavaScript

local js_for_loop = s(
  { trig = "for([%w_]+)", regTrig = true, hidden = true },
  fmt(
    [[
  for (var {} = 0; {} < {}; {}++) {{
    {}
  }}

  {}
  ]] ,
    {
      d(1, function(_, snip)
        return sn(1, i(1, snip.captures[1]))
      end),
      rep(1),
      c(2, { i(1, "$NUM"), sn(1, { i(1, "$ARR"), t(".length") }) }),
      rep(1),
      i(3, "// TODO: "),
      i(4),
    }
  )
)

local js_function = s(
  "func",
  fmt(
    [[
    {} {} {} {{
      {}
    }}
  ]] ,
    {
      -- TODO: Snippet Behavior
      d(1, function(_, snip)
        return sn(
          1,
          c(1, {
            i(1, "function"),
            i(1, "const"),
          })
        )
      end),
      i(2, "$NAME"),
      c(3, {
        sn(1, {
          t("= ("),
          i(1, "$ARGS"),
          t(") => "),
        }),
        sn(1, { t("= function("), i(1, "$ARGS"), t(") ") }),
      }),
      i(4, "// TODO: Implementation"),
    }
  )
)

-- ES6 Focused

local es_arrow_function = s(
  ";esf",
  fmt(
    [[
    const {} = ({}) => {{
      {}
    }}
  ]] ,
    {
      i(1, "$NAME"),
      i(2, "$ARGS"),
      i(3, "// TODO: Implemntation"),
    }
  )
)

-- Snippets --
-- table.insert(snippets, react_functional_component)
-- table.insert(snippets, react_useState)
-- table.insert(snippets, react_useEffect)

table.insert(snippets, js_for_loop)
table.insert(snippets, js_function)

-- AutoSnippets
table.insert(autosnippets, es_arrow_function)

-- React
-- local react_snippets = require("dev.snippets.react")
-- local REACT_PROJECT_DIR = "~/Projects/web/React/*"
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = REACT_PROJECT_DIR,
--   group = group,
--   callback = function()
--     react_snippets.tableBuilder(snippets, autosnippets)
--   end,
-- })

return snippets, autosnippets

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

local group = vim.api.nvim_create_augroup("All Snippets", { clear = false })
local file_pattern = { "*.javascript", "*.javascriptreact" }

-------------------------
-- Helpers
-------------------------

-------------------------
-- Snippet Definitions
-------------------------

-- TODO: Need to make the export statement a condition
local react_functional_component = s(
  "rfc",
  fmt(
    [[
  const {} = ({}) => {{
    {}
    return (
      <>
        <div>{}</div>
      </>
    )
  }}

  export {{{}}};
  ]] ,
    {
      -- TODO: Make Better W/ Function : )
      d(1, function(_, snip)
        return sn(1, i(1, snip.captures[1]))
      end),
      c(2, {
        t("{}"),
        t(""),
      }),
      c(3, {
        i(1, ""),
        i(2, "$STATE"),
      }),
      -- i(4, "$COMPONENT_NAME"),
      -- i(5, "$COMPONENT_NAME"),
      rep(1),
      rep(1),
    }
  )
)

local react_useState = function(trigger)
  return s(
    trigger,
    fmt(
      [[
  const [{}, set{}] = useState({});
  ]]   ,
      {
        d(1, function(_, snip)
          return sn(1, i(1, snip.captures[1]))
        end),
        rep(1),
        i(2, ""),
      }
    )
  )
end

local react_useEffect = function(trigger)
  return s(
    trigger,
    fmt(
      [[
  useEffect(() => {{
    {}
    return () => ({{
      {}
    }})
  }}, [{}])
  ]]   ,
      {
        i(1, "// TODO: Side Effect"),
        i(2, "// TODO: Cleanup"),
        i(3, "/* TODO: Add Dependencies */"),
      }
    )
  )
end

local react_reducer_dispatch = function(trigger)
  return s(
    trigger,
    fmt(
      [[
    function {}({}, {}) {
      const {{{}}} = {};
      const {{TYPE}} = {};

      switch(TYPE) {
        case {}: 
          {}
        default:
          {}
      }
    }
    ]] ,
      {
        i(1, "$DISPATCH_NAME"),
        d(2, function(_, snip)
          return sn(1, i(1, snip.captures[1]))
        end),
        d(3, function(_, snip)
          return sn(1, i(1, snip.captures[1]))
        end),
        i(1, "$DESTRUCTURE"),
        rep(3),
        rep(2),
        i(7, "$CASE"),
        i(8, "// TODO: Case Implementation"),
        i(9, "// TODO: Case Implementation"),
      }
    )
  )
end

-------------------------
-- Setup
-------------------------
table.insert(snippets, react_useEffect("ue"))
table.insert(autosnippets, react_useEffect(";ue"))
table.insert(snippets, react_useState("us"))
table.insert(autosnippets, react_useState(";us"))
table.insert(snippets, react_functional_component)

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   pattern = { "*.javascriptreact" },
--   callback = function(ev)
--     print(string.format("event fired: s", vim.inspect(ev)))
--   end,
-- })
--
-- -- Teardown
-- vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
--   pattern = { "*.javascriptreact" },
--   callback = function()
--     snippets = {}
--     autosnippets = {}
--   end,
-- })

return snippets, autosnippets

local status, ls = pcall(require, "luasnip")

if not status then
  -- print("ERROR: plugin 'luasnip' is unavailable")
  return
end

ls.snippets = {
  all = {
    ls.parser.parse_snippet("td", "- [] "),
  },
  lua = {
    ls.parser.parse_snippet("lf", "local $1 = function($2)\n $0\nend"),
    ls.parser.parse_snippet("mf", "$1.$2 = function($3)\n $0\nend"),
  },
  javascript = {},
}

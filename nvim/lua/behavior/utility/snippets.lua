local M = {}

local ls = require("luasnip")
local s = ls.s --> sinppet
local i = ls.i

local map_snippet = vim.keymap.set

local filetype_pattern
local group

local snippets, autosnippets = {}, {}

-------------------------
-- Builder Functions
-------------------------
--[[
Call at start. Setup boilerplate.

opts: (table) = {
  pattern: (string), -- File glob to validate
  group: (string), -- Group Name for aucommands
}
--]]
function M.init_snippets(opts)
  filetype_pattern = opts.pattern
  group = vim.api.nvim_create_augroup(opts.group, { clear = false })
end

--[[
Add keymaps to the current buffer.

keymap_table: (table) -- keys to map
 = key (string) -- To map snippet to
 = snippet (*snippet) -- Snippet to launch when triggered
 = pattern (string) -- Alternative filetype pattern to use
--]]
local function add_keymaps(keymap_table)
  for _, map in ipairs(keymap_table) do
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = map.pattern,
      group = group,
      callback = function()
        map_snippet({ "i" }, map.key, function()
          ls.snip_expand(map.snippet)
        end, { noremap = true, silent = true, buffer = true })
      end,
    })
  end
end

--[[
Sinppet builder helper.

snippet_opts: (table) -- Trigger + documentation for snippet 
snippet_nodes: (table) -- Snippet definition
opts: (table) = {
  pattern: (string), -- File glob to validate
  keys: (string|table), -- Either a single keymap or a collection of maps
}
target_table: (table) -- Either snippets or autosnippets
--]]
function M.cs(snippet_opts, snippet_nodes, opts)
  local snippet = s(snippet_opts, snippet_nodes)

  local pattern = filetype_pattern
  local keymaps = {}

  if opts ~= nil then
    -- Alternative Pattern
    if opts.pattern ~= nil then
      pattern = opts.pattern
    end

    -- Add Keybindings
    if opts.keys ~= nil then
      -- Add a single binding
      if type(opts.keys) == "string" then
        table.insert(keymaps, opts.keys)
      end

      -- Add a table of bindings
      if type(opts.keys) == "table" then
        local all_keys = opts.keys
        for _, key in ipairs(all_keys) do
          vim.api.nvim_create_autocmd("BufEnter", {
            pattern = pattern,
            group = group,
            callback = function()
              map_snippet({ "i" }, opts.keys[_], function()
                ls.snip_expand(snippet)
              end, { noremap = true, silent = true, buffer = true })
            end,
          })
        end
      elseif type(opts.keys) == "string" then
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = pattern,
          group = group,
          callback = function()
            map_snippet({ "i" }, opts.keys, function()
              ls.snip_expand(snippet)
            end, { noremap = true, silent = true, buffer = true })
          end,
        })
      end
    end
  end

  table.insert(snippets, snippet)
end

M.snippets = snippets

return M

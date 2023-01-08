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

-- local function addKeys(keys, pattern, group, snippet)
--   if pattern ~= nil then
--     for _, map in ipairs(keys) do
--       vim.api.nvim_create_autocmd("BufEnter", {
--         pattern = pattern,
--         group = group,
--         callback = function()
--           vim.keymap.set(map[1], map[2], function()
--             s.snip_expand(snippet)
--           end,
--             { noremap = true, silent = true, buffer = true })
--         end
--       })
--     end
--   end
-- end

-- TODO: Implement dynamic addition of keymaps and snippets
-- local function add(table, trigger, nodes, opts, pattern, key)
--   local snippet = s(trigger, nodes)
--   local fileType = vim.
--   if pattern ~= nil then
--     table.insert(table, snippet)
--   end
-- end

-- local function cs(trigger, nodes, opts)
--   local snippet = s(trigger, nodes)
--   local target_table = snippets -- Default
--
--   local pattern = file_pattern
--   local keymaps = {}
--
--   if opts ~= nil then
--     -- Cheeck for Custom Pattern
--     if opts.pattern then
--       pattern = opts.pattern
--     end
--
--     -- If opts is a String
--     if type(opts) == "string" then
--       -- If it's an autosnippet
--       if opts == "auto" then
--         target_table = autosnippets
--       else
--         table.insert(keymaps, { "i", opts })
--       end
--     end
--
--     -- if opts is a table
-- 		if opts ~= nil and type(opts) == "table" then
-- 			for _, keymap in ipairs(opts) do
-- 				if type(keymap) == "string" then
-- 					table.insert(keymaps, { "i", keymap })
-- 				else
-- 					table.insert(keymaps, keymap)
-- 				end
-- 			end
-- 		end
--
-- 		-- set autocmd for each keymap
-- 		if opts ~= "auto" then
-- 			for _, keymap in ipairs(keymaps) do
-- 				vim.api.nvim_create_autocmd("BufEnter", {
-- 					pattern = pattern,
-- 					group = group,
-- 					callback = function()
-- 						vim.keymap.set(keymap[1], keymap[2], function()
-- 							ls.snip_expand(snippet)
-- 						end, { noremap = true, silent = true, buffer = true })
-- 					end,
-- 				})
-- 			end
-- 		end
--
--     table.insert(target_table, snippet)
--   end
-- end

-------------------------
-- Snippet Definitions
-------------------------

-------------------------
-- Setup
-------------------------

-- Snippets

-- Autosnippets

return snippets, autosnippets

----------------------------
-- Notes about this config
----------------------------

-- CMP handles completion mappings, meaning this file only contains mappings for
-- expanding and jumping through a snippet.

local status, ls = pcall(require, "luasnip")
if not status then
  -- print("ERROR: plugin 'luaSnip' is unavailable")
  return
end

local types = require("luasnip.util.types")

-- Snippets Location
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

-- NOTE: not too sure, but here for posterity
-- Access any *SELECT* variable
-- require("luasnip").config.setup({ store_selection_keys = "<C-l>" })

-- Quick Editing
vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()]])

-------------------------
-- Config
-------------------------

ls.config.set_config({
  -- Remember to keep around the last snippet.
  -- Lets you go back into it if you move outside of the selection
  history = true,

  -- Update dynamic snippets as you type
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets
  enable_autosnippets = true,

  -- Highlights
  ext_opts = {
    [types.insertNode] = {
      active = {
        virt_text = { { "", "Success" } },
      },
      -- unvisited = {
      --   hl_group = "DiffChange",
      -- },
      -- visited = {
      --   hl_group = "Search",
      -- },
    },
    [types.choiceNode] = {
      active = {
        virt_text = { { "", "Error" } },
      },
      -- unvisited = {
      --   hl_group = "DiffChange",
      -- },
      -- visited = {
      --   hl_group = "Search",
      -- },
    },
  },
})

-------------------------
-- Key Maps
-------------------------

-- Select Next Choice
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  -- vim.keymap.set("i", "<Tab>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
vim.keymap.set({ "i", "s" }, "<c-n>", function()
  -- vim.keymap.set("i", "<Tab>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- Select Prev Choice
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)
vim.keymap.set({ "i", "s" }, "<c-p>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)

-- Quickly Add A Blank Line (Can Navigate Through Snippet After)
vim.keymap.set({ "i", "s" }, "<c-y>", "<esc>o", { silent = true })

-- Quickly Edit The Current Buffer's Associated Snippets (Telescope picker)
vim.keymap.set("n", "<Leader><CR>", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })

-- Use Namespaced LuaSnip Hints
vim.cmd([[
augroup choice_popup
au!
au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
au User LuasnipChoiceNodeLeave lua choice_popup_close()
au User LuasnipChangeChoice lua update_choice_popup(require('luasnip').session.event_node)
augroup END
]])
-- vim.keymap.set("n", "<Leader><tab>", "<cmd>lua choice_popup_close()<cr>", { silent = true, noremap = true })
-- vim.keymap.set("i", "<C-Space>", "<cmd>lua choice_popup_close()<cr>", { silent = true, noremap = true })
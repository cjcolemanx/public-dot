local status = pcall(require, "telescope")
if not status then
  print("ERROR: nvim-telescope is unavailable for custom pickers")
  return
end

local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local keymap_popup = require("ui.popups.telescope-binds")

-------------------------
-- => Functions
-------------------------
local function parseFiles(dir)
  -- TODO: Implement
  -- function! s:tree(dir)
  --                     return {a:dir : map(readdir(a:dir),
  --       \ {_, x -> isdirectory(x) ?
  --       \          {x : s:tree(a:dir .. '/' .. x)} : x})}
  --                 endfunction
  --                 echo s:tree(".")
end

-------------------------
-- => Actions
-------------------------
local function enter(prompt_bufnr)
  local selected = action_state.get_selected_entry()
  keymap_popup.close_telescope_binds_popup()
  actions.close(prompt_bufnr) -- close before focusing a new buffer
  vim.cmd({ cmd = "vnew", args = { selected } })
end

local function next_file(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
end

local function prev_file(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
end

-------------------------
-- => Config
-------------------------
local defaultOpts = require("ui.pickers.defaults").config_files
local config_dir = vim.fn.readdir(defaultOpts.location)
-- local config_dir = vim.fs.dir(defaultOpts.location)

local style_mini = {
  layout_strategy = "horizontal",
  layout_config = {
    width = 0.5,
    preview_width = 0.65,
    prompt_position = "top",
  },
  sorting_strategy = "ascending",
}

local opts = {
  finder = finders.new_table(config_dir),
  sorter = sorters.get_generic_fuzzy_sorter({}),
  previewer = previewers.new_termopen_previewer({
    get_command = function(entry, status)
      return { "echo", entry[1] }
    end,
  }),
  prompt_prefix = "> ",
  results_title = "\\ Config Files /",
  preview = true,
  attach_mappings = function(prompt_bufnr, map)
    map("i", "<CR>", enter)
    map("i", "<ESC>", function()
      keymap_popup.close_telescope_binds_popup()
      actions.close(prompt_bufnr)
    end)
    map("i", "<C-l>", enter)
    return true
  end,
}

local keybinds_table = {
  "<CR>  = TODO",
  "<C-l> = TODO",
}

keymap_popup.add_telescope_binds(keybinds_table, "config-files")

local config_files = pickers.new(style_mini, opts)

local function open_config_telescope()
  config_files:find()
  keymap_popup.open_telescope_binds_popup("config-files")
end

local fs = require("behavior.functions.fs.directories")
local list = fs.create_tree_from_root(defaultOpts.location)

vim.keymap.set("n", ";<space>c", function()
  open_config_telescope()
end)

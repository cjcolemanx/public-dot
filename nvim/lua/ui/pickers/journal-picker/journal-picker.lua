-- TODO: Refactor into plugin (add a setup and such)
local status = pcall(require, "telescope")
if not status then
  print("ERROR: nvim-telescope is unavailable for custom pickers")
  return
end

local previewers = require("telescope.previewers")
-- local themes = require("telescope.themes")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local style_mini = {
  layout_strategy = "horizontal",
  -- layout_config = {
  --   height = 0.5,
  --   width = 0.3,
  --   prompt_position = "bottom",
  -- },
  layout_config = {
    preview_width = 0.65,
    prompt_position = "top",
    width = 0.4,
  },
  sorting_strategy = "ascending",
}

local defaultOpts = require("ui.pickers.defaults").journal_picker
local location = defaultOpts.location
local journal_items = defaultOpts.journal_items

local function enter(prompt_bufnr)
  -- FIXME: TESTING stuff
  -- local log_file = io.open("journal-picker-log.txt", "w")
  -- local prompt_bufnr = action_state.get_current_picker(prompt_bufnr).prompt_bufnr
  -- log_file:write("Current Line: " .. vim.inspect(action_state.get_current_line()))
  -- log_file:write("\n\nCurrent History: " .. vim.inspect(action_state.get_current_history()))
  -- -- log_file:write("\n\nCurrent Picker: " .. vim.inspect(action_state.get_current_picker(prompt_bufnr)))
  -- -- log_file:write("\n\n" .. vim.inspect(action_state))
  -- log_file:write("\n\nCurrent Prompt Buffer: " .. prompt_bufnr)
  -- local picker = action_state.get_current_picker(prompt_bufnr)
  -- log_file:write("\n\nCurrent Prompt: " .. vim.inspect(picker:_get_prompt()))
  -- log_file:close()

  local selected = action_state.get_selected_entry()[1]
  actions.close(prompt_bufnr)
  vim.cmd({ cmd = "vnew", args = { location .. selected } })

  -- Change to journal directory (for current buffer)
  vim.cmd({ cmd = "lcd", args = { location } })
end

local function next_option(prompt_bufnr)
  actions.move_selection_next(prompt_bufnr)
end

local function prev_option(prompt_bufnr)
  actions.move_selection_previous(prompt_bufnr)
end

local opts = {
  finder = finders.new_table(journal_items),
  sorter = sorters.get_generic_fuzzy_sorter({}),
  -- previewer = previewers.cat.new({
  --   setup = function() end,
  --   teardown = function() end,
  -- }),
  previewer = previewers.new_termopen_previewer({
    get_command = function(entry, status)
      return { "cat", location .. entry[1] }
    end,
  }),
  prompt_title = "\\ Open Journal /",
  prompt_prefix = "> ",
  results_title = "Results",
  preview = true,
  attach_mappings = function(prompt_bufnr, map)
    map("i", "<CR>", enter)
    map("i", "<C-l>", enter)
    map("i", "<C-j>", next_option)
    map("i", "<C-k>", prev_option)

    map("n", "<CR>", enter)
    map("n", "o", enter)
    map("n", "j", next_option)
    map("n", "k", prev_option)
    return true
  end,
}

local journal_picker = pickers.new(style_mini, opts)

vim.keymap.set("n", ";<space>j", function()
  journal_picker:find()
end)

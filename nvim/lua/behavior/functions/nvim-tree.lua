local M = {}

-- Dependencies
local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")

-- Functions

-- git stage/unstage file from nvimtree
-------------------------
-- => Git
-------------------------
--[[
$DESC

$PARAMS
--]]
local function git_add()
  local node = lib.get_node_at_cursor()
  local gs = node.git_status

  if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
    -- If the file is untracked, unstaged or partially staged, we stage it
    vim.cmd("silent !git add " .. node.absolute_path)
  elseif gs == "M " or gs == "A " then
    -- If the file is staged, we unstage
    vim.cmd("silent !git restore --staged " .. node.absolute_path)
  end

  lib.refresh_tree()
end

-------------------------
-- => Telescope
-------------------------
local openfile = require("nvim-tree.actions.node.open-file")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

--[[
$DESC

$PARAMS
--]]
local view_selection = function(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local filename = selection.filename
    if filename == nil then
      filename = selection[1]
    end
    openfile.fn("preview", filename)
  end)
  return true
end

function M.launch_live_grep(opts)
  return M.launch_telescope("live_grep", opts)
end

function M.launch_find_files(opts)
  return M.launch_telescope("find_files", opts)
end

function M.launch_telescope(func_name, opts)
  local telescope_status_ok, _ = pcall(require, "telescope")
  if not telescope_status_ok then
    return
  end
  local lib_status_ok = pcall(require, "nvim-tree.lib")
  if not lib_status_ok then
    return
  end
  local node = lib.get_node_at_cursor()
  local is_folder = node.fs_stat and node.fs_stat.type == "directory" or false
  local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
  if node.name == ".." and TreeExplorer ~= nil then
    basedir = TreeExplorer.cwd
  end
  opts = opts or {}
  opts.cwd = basedir
  opts.search_dirs = { basedir }
  opts.attach_mappings = view_selection
  return require("telescope.builtin")[func_name](opts)
end

local tree_actions = {
  {
    name = "Create node",
    handler = require("nvim-tree.api").fs.create,
  },
  {
    name = "Remove node",
    handler = require("nvim-tree.api").fs.remove,
  },
  {
    name = "Trash node",
    handler = require("nvim-tree.api").fs.trash,
  },
  {
    name = "Rename node",
    handler = require("nvim-tree.api").fs.rename,
  },
  {
    name = "Fully rename node",
    handler = require("nvim-tree.api").fs.rename_sub,
  },
  {
    name = "Copy",
    handler = require("nvim-tree.api").fs.copy.node,
  },
}

function M.tree_actions_menu(node)
  local entry_maker = function(menu_item)
    return {
      value = menu_item,
      ordinal = menu_item.name,
      display = menu_item.name,
    }
  end

  local finder = require("telescope.finders").new_table({
    results = tree_actions,
    entry_maker = entry_maker,
  })

  local sorter = require("telescope.sorters").get_generic_fuzzy_sorter()

  local default_options = {
    finder = finder,
    sorter = sorter,
    prompt_title = "\\ Actions /",
    attach_mappings = function(prompt_buffer_number)
      local actions = require("telescope.actions")

      -- On item select
      actions.select_default:replace(function()
        local state = require("telescope.actions.state")
        local selection = state.get_selected_entry()
        -- Closing the picker
        actions.close(prompt_buffer_number)
        -- Executing the callback
        selection.value.handler(node)
      end)

      -- The following actions are disabled in this example
      -- You may want to map them too depending on your needs though
      actions.add_selection:replace(function() end)
      actions.remove_selection:replace(function() end)
      actions.toggle_selection:replace(function() end)
      actions.select_all:replace(function() end)
      actions.drop_all:replace(function() end)
      actions.toggle_all:replace(function() end)

      return true
    end,
  }

  -- Opening the menu
  require("telescope.pickers").new({ prompt_title = "Tree menu" }, default_options):find()
end

-------------------------
-- => Common
-------------------------
--[[
$DESC

$PARAMS
--]]
function M.split_below()
  local node = lib.get_node_at_cursor()
  local action = "split"

  if node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
      require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
    elseif node.nodes ~= nil then
      lib.expand_or_collapse(node)
    else
      require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
    end

    local ctrl_w = vim.api.nvim_replace_termcodes("<C-W>", true, false, true)
    vim.api.nvim_feedkeys(ctrl_w .. "r", "nx", false)
  end
end

--[[
$DESC

$PARAMS
--]]
function M.split_below_and_refocus()
  local node = lib.get_node_at_cursor()
  local action = "split"

  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
  end

  local ctrl_w = vim.api.nvim_replace_termcodes("<C-W>", true, false, true)

  vim.api.nvim_feedkeys(ctrl_w .. "r", "nx", false)

  -- Finally refocus on tree if it was lost
  view.focus()
end

--[[
$DESC

$PARAMS
--]]
function M.split_right()
  local node = lib.get_node_at_cursor()
  local action = "vsplit"

  if node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
      require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
    elseif node.nodes ~= nil then
      lib.expand_or_collapse(node)
    else
      require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
    end

    local ctrl_w = vim.api.nvim_replace_termcodes("<C-w>", true, false, true)
    vim.api.nvim_feedkeys(ctrl_w .. "x", "nx", false)
  end
end

--[[
$DESC

$PARAMS
--]]
function M.split_right_and_refocus()
  local node = lib.get_node_at_cursor()
  local action = "vsplit"
  -- local nt = require("nvim-tree.api")

  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
  end

  vim.cmd("NvimTreeClose")
  local ctrl_w = vim.api.nvim_replace_termcodes("<C-w>", true, false, true)
  vim.api.nvim_feedkeys(ctrl_w .. "r", "nx", false)
  vim.cmd("NvimTreeOpen")
end

--[[
$DESC

$PARAMS
--]]
function M.expand_folder()
  local node = lib.get_node_at_cursor()

  if node.nodes ~= nil then
    lib.expand_or_collapse(node)
  end
end

-- Easier CWD
function M.change_root_to_global_cwd()
  local api = require("nvim-tree.api")
  local global_cwd = vim.fn.getcwd(-1, -1)

  print("Changed gobal cwd")

  api.tree.change_root(global_cwd)
end

-- Add to module
M.git_add = git_add

return M

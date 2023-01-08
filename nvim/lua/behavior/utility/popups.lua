local M = {}
local popups, popup_helpers = {}, {}

local status = pcall(require, "notify")
if not status then
  print("ERROR: nvim-notify is not available")
end

local notify_stages = {
  [1] = "fade_in_slide_out",
  [2] = "fade",
  [3] = "slide",
  [4] = "static",
}

local notify_render_style = {
  [1] = "default",
  [2] = "minimal",
  [3] = "simple",
}

local instance_config = {
  background_colour = "#FFFFFF",
  fps = 30,
  level = 2,
  minimum_width = 20,
  render = "minimal",
  stages = notify_stages[1],
  timeout = 3000,
  top_down = true,
}

local current_popup = {}

-------------------------
-- Popups
-------------------------

local messagePopUp = function(message, index)
  -- vim.api.nvim_notify("Hello", 1, {})
  -- vim.ui.input({ prompt = message })
  -- FIXME: Need to destructure the config for replacement
  -- local instance = instance_config
  -- local n = require("notify").instance(table.insert(instance, { replace = index - 1, })
  local n = require("notify")
  local i = n.instance(instance_config)
  local p = i.notify(message, "info", { title = "Snippet:" })

  print(n.Record)

  return p
end

-------------------------
-- Helpers
-------------------------

-------------------------
-- Register
-------------------------

popups.messagePopUp = messagePopUp

M.popups = popups
M.popup_helpers = popup_helpers

return M

local M = {}

local n = require("notify")

local keybinds = {
  ["session-picker"] = "",
  ["config-files"] = "",
  ["tab-manager"] = "",
}

local options = {
  background_colour = "#FFFFFF",
  timeout = false,
  title = " Keybinds ",
  stages = "static",
}

M.open_telescope_binds_popup = function(target_key)
  n.notify(keybinds[target_key], "info", options)
end

M.close_telescope_binds_popup = function()
  n.dismiss()
end

M.add_telescope_binds = function(keys, target_key)
  for _, key in pairs(keys) do
    keybinds[target_key] = keybinds[target_key] .. key .. "\n"
  end
end

return M

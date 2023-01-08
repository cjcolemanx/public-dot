local status, hs = pcall(require, "high-str")

if not status then
  -- print("Error: High-str.nvim is unavailable")
  return
end

hs.setup({
  {
    verbosity = 0,
    saving_path = "/tmp/highstr/",
    highlight_colors = require("ui.look.high-str-colors").highlight_colors,
  },
})

require("keymaps.plugin-maps").high_str_binds()

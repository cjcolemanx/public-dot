local status, comment = pcall(require, "Comment")
if not status then
  -- print("ERROR: plugin 'Comment' is unavailable")
  return
end

-- TODO

local keys = require("keymaps.plugin-maps").comment()

comment.setup({
  padding = true, -- space after comment symbol
  sticky = true, -- cursor stays in position
  toggler = keys.toggler,
  opleader = keys.opleader,
  extra = keys.extra,
})

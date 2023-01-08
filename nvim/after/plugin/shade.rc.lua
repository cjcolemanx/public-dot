-- FIXME: this guy is breaking popups
-- local status, shade = pcall(require, "shade")

local status = false

if not status then
  return
end

shade.setup({
  overlay_opacity = 60,
  opacity_step = 1,
  keys = {},
})

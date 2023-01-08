local status, nightfox = pcall(require, "nightfox")

if not status then
  print("ERROR: plugin 'nightfox' is unavailable")
  return
end

nightfox.setup({
  options = {
    styles = { comments = "italic", functions = "italic,bold" },
    transparent = true,
    dim_inactive = true,
    terminal_colors = true,
  },
})

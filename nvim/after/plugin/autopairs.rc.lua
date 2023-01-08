local status, autopairs = pcall(require, "nvim-autopairs")

if not status then
  -- print("ERROR: plugin 'nvim-autopairs' is unavailable")
  return
end

autopairs.setup({})

local status, surround = pcall(require, "nvim-surround")

if not status then
  return
end

-- FIXME: Move to global folder
local keymaps = {
  normal = "yp",
  normal_line = "yP",
  normal_cur = "ypp",
  normal_cur_line = "yPP",
  insert = "<M-g>p",
  insert_line = "<M-g>P",
  visual = "P",
  visual_line = "gP",
  delete = "dp",
  change = "cp",
}

surround.setup({
  keymaps = keymaps,
})

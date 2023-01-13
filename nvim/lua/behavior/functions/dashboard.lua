local db = require("dashboard")
local M = {}

--[[
The augroup for cursor movement is 'Dashboard CursorMoved Autocmd'
--]]
function M.add_dashboard_cursoritem_highlights(bufnr)
  -- local bufnr = vim.api.nvim_get_current_buf()
  -- Make it work
  -- vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
  -- local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  -- FIXME: Hardcoded atm
  -- vim.api.nvim_buf_add_highlight(bufnr, -1, "DashboardOptionHighlight", row, col, col + 20)
  require("dashboard"):instance(true)
end

return M

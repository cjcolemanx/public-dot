local M = {}

local table_utils = require("myUtility.tables")

local function checkLanguageServer()
  local server = vim.lsp.get_active_clients()
  table_utils.printTable(server, 0)

  -- print("CALLED")
  -- print(server)
  --
  -- for _, s in ipairs(server) do
  --   print(s["name"])
  -- end
end

M.checkLanguageServer = checkLanguageServer

return M

local M = {}

local function printTable(tb, nested_iterations)
  print("printing table")
  -- local printable = table.concat(tb, "\n")
  -- vim.cmd({ cmd = "echo", args = { printable } })
  -- vim.cmd({ cmd = "echo", args = { "hello" } })
  for _, item in ipairs(tb) do
    -- if nested_iterations > 0 then
    --   printTable(item, nested_iterations - 1)
    -- else
    --   print(vim.inspect(item))
    -- end
    print(vim.inspect(item.name))
  end
end

M.printTable = printTable

return M

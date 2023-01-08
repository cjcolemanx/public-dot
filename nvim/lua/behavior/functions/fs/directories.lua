local M = {}

-- FIXME:
M.create_tree_from_root = function(root_dir)
  local files = vim.fs.dir(root_dir)
  -- return { files = files, root = root_dir }
  -- for a, b in files(a) do
  --   -- print(vim.inspect(list) .. defaultOpts.location)
  --   print(vim.inspect(a))
  -- end
  return files
end

return M

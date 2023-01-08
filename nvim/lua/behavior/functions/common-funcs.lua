local Job = require("plenary.job")

local M = {}

function M.notify_current_datetime()
  local dt = vim.fn.strftime("%c")
  require("notify")("Current Date Time: " .. dt, "info", { title = "Date & Time" })
end

function M.yank_current_file_name()
  local file_name = vim.api.nvim_buf_get_name(0)
  local input_pipe = vim.loop.new_pipe(false)

  local yanker = Job:new({
    writer = input_pipe,
    command = "pbcopy",
  })

  yanker:start()
  input_pipe:write(file_name)
  input_pipe:close()
  yanker:shutdown()

  require("notify")("Yanked: " .. file_name, "info", { title = "File Name Yanker", timeout = 1000 })
end

function M.toggle_bool(args)
  if args.word == "true" then
    vim.cmd([[norm ciwfalse]])
  elseif args.word == "false" then
    vim.cmd([[norm ciwtrue]])
  else
    print("Word under cursor must be either 'true' or 'false'")
  end
end

return M

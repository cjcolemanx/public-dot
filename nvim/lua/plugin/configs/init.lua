local ENV = vim.g.startenv

local configs = {}

if ENV == "react" then
  configs = { require("plugin.configs.react") }
end
if ENV == "journal" then
  configs = { require("plugin.configs.journal") }
end
if ENV == "notes" then
  configs = { require("plugin.configs.notes") }
end
if ENV == "base" then
  configs = { require("plugin.configs.dev") }
end

return configs

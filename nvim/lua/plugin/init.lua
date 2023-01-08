if vim.g.vscode then
  require("plugin.packer-vs")
else
  require("plugin.packer")
  require("plugin.configs")
end

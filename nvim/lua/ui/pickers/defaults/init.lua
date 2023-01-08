local M = {}
-- TODO: Implement
M.journal_picker = {
  -- find in `lua/behavior/global/variables`
  location = vim.g.personal_wiki_path,
  journal_items = {
    "TOC.md",
  },
}

-- You can't have mine...
M.config_files = {
  location = "$HOME/.config/nvim/",
}

-- You can't have mine...
M.documentation_picker = {
  location = "$HOME/Downloads/Dash-User-Contributions/docsets/",
}

return M

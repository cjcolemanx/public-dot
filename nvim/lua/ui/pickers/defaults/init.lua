local M = {}
-- TODO: Implement
M.journal_picker = {
  location = vim.g.personal_wiki_path,
  journal_items = {
    "tasks/TOC.md",
    "journal/TOC.md",
    "goals/TOC.md",
  },
}

M.config_files = {
  location = "/home/charles/.config/nvim/",
}

M.documentation_picker = {
  location = "/mnt/A/notes/_docsets/Dash-User-Contributions/docsets/",
}

return M

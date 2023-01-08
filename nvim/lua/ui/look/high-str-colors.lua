local M = {}

M.highlight_colors = {
  color_1 = { "#0c0d0e", "smart" },
  color_2 = { "#e5c07b", "smart" },
  color_3 = { "#7fffd4", "smart" },
  color_4 = { "#8a2be2", "smart" },
  color_5 = { "#ff4500", "smart" },
  color_6 = { "#008000", "smart" },
  color_7 = { "#0000ff", "smart" },
  color_8 = { "#fff9e3", "smart" },
  color_9 = { "#7d5c34", "smart" },
}

function M.get_highlight_colors()
  return {
    { "1", "#0c0d0e" },
    { "2", "#e5c07b" },
    { "3", "#7fffd4" },
    { "4", "#8a2be2" },
    { "5", "#ff4500" },
    { "6", "#008000" },
    { "7", "#0000ff" },
    { "8", "#fff9e3" },
    { "9", "#7d5c34" },
  }
end

return M

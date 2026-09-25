local M = {}

function M.load()
  vim.o.background = "dark"
  vim.cmd.runtime("colors/vim.lua")

  local palette = require("xuantong.palette")
  require("xuantong.highlights").apply(palette)
  vim.g.colors_name = "xuantong"
end

return M

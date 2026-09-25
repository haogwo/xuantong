vim.opt.runtimepath:prepend(vim.fn.getcwd())
vim.o.termguicolors = true

local function color(name, key)
  local value = vim.api.nvim_get_hl(0, { name = name, link = false })[key]
  return value and string.format("#%06x", value) or nil
end

local function check()
  vim.cmd.colorscheme("xuantong")
  assert(vim.g.colors_name == "xuantong")
  assert(color("Normal", "bg") == "#282a36")
  assert(color("Comment", "fg") == "#a4ffff")
  assert(color("SignColumn", "bg") == "#282a36")
  assert(color("CursorLine", "bg") == "#45475a")
  assert(color("CursorColumn", "bg") == "#45475a")
  assert(color("@variable.parameter.python", "fg") == "#d6acff")
  assert(color("@function.call.python", "fg") == "#bd93f9")

  vim.cmd.colorscheme("default")
  vim.cmd.colorscheme("xuantong")
  assert(color("Comment", "fg") == "#a4ffff")
end

local ok, error_message = pcall(check)
if not ok then
  vim.api.nvim_err_writeln(error_message)
  vim.cmd("cquit 1")
end

print("xuantong smoke test passed")

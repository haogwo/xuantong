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
  assert(color("Comment", "fg") == "#6272a4")
  assert(color("@comment", "fg") == "#6272a4")
  assert(color("LineNr", "fg") == "#6272a4")
  assert(color("LineNrAbove", "fg") == "#6272a4")
  assert(color("LineNrBelow", "fg") == "#6272a4")
  assert(color("CursorLineNr", "fg") == "#bd93f9")
  assert(color("SignColumn", "bg") == "#282a36")
  assert(color("CursorLine", "bg") == "#45475a")
  assert(color("CursorColumn", "bg") == "#45475a")
  assert(color("NormalFloat", "fg") == "#f8f8f2")
  assert(color("NormalFloat", "bg") == "#45475a")
  assert(color("FloatBorder", "bg") == "#45475a")
  for _, group in ipairs({ "Pmenu", "PmenuKind", "PmenuExtra", "PmenuMatch" }) do
    assert(color(group, "bg") == "#45475a")
  end
  for _, group in ipairs({ "PmenuSel", "PmenuMatchSel", "LspSignatureActiveParameter" }) do
    assert(color(group, "bg") == "#6272a4")
  end
  assert(color("PmenuSbar", "bg") == "#282a36")
  assert(color("PmenuThumb", "bg") == "#6272a4")
  assert(color("@variable.parameter.python", "fg") == "#d6acff")
  assert(color("@function.call.python", "fg") == "#bd93f9")

  vim.cmd.colorscheme("default")
  vim.cmd.colorscheme("xuantong")
  assert(color("Comment", "fg") == "#6272a4")
  assert(color("LineNr", "fg") == "#6272a4")
  assert(color("CursorLineNr", "fg") == "#bd93f9")
  assert(color("NormalFloat", "bg") == "#45475a")
  assert(color("Pmenu", "bg") == "#45475a")
end

local ok, error_message = pcall(check)
if not ok then
  vim.api.nvim_err_writeln(error_message)
  vim.cmd("cquit 1")
end

print("xuantong smoke test passed")

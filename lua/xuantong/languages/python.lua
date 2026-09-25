local M = {}

function M.groups(palette)
  return {
    ["@variable.python"] = palette.foreground,
    ["@variable.parameter.python"] = palette.ansi[13],
    ["@variable.member.python"] = palette.ansi[7],
    ["@function.python"] = palette.ansi[5],
    ["@function.call.python"] = palette.ansi[5],
    ["@function.method.python"] = palette.ansi[5],
    ["@function.method.call.python"] = palette.ansi[5],
    ["@constructor.python"] = "#87ffaf",
    ["@module.python"] = palette.ansi[7],
  }
end

return M

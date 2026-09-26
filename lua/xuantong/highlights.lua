local M = {}

local function xterm_rgb(index, palette)
  if index < 16 then
    return palette.ansi[index + 1]
  end

  if index < 232 then
    local cube = { 0, 95, 135, 175, 215, 255 }
    local value = index - 16
    return string.format(
      "#%02x%02x%02x",
      cube[math.floor(value / 36) + 1],
      cube[math.floor(value / 6) % 6 + 1],
      cube[value % 6 + 1]
    )
  end

  local grey = 8 + (index - 232) * 10
  return string.format("#%02x%02x%02x", grey, grey, grey)
end

function M.apply(palette)
  -- Preserve Vim's links and attributes while replacing terminal color numbers.
  for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
    local update = { update = true }
    if hl.ctermfg then
      update.fg = xterm_rgb(hl.ctermfg, palette)
    end
    if hl.ctermbg then
      update.bg = xterm_rgb(hl.ctermbg, palette)
    end
    if update.fg or update.bg then
      vim.api.nvim_set_hl(0, name, update)
    end
  end

  -- Vim leaves Normal unset; use the terminal theme's foreground and background.
  vim.api.nvim_set_hl(0, "Normal", { fg = palette.foreground, bg = palette.background })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = palette.background, update = true })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = palette.cursor_background, update = true })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = palette.cursor_background, update = true })

  -- Match popup surfaces to the editor background while keeping the selected
  -- completion item distinct.
  local popup_bg = palette.background
  local selected_bg = palette.ansi[9]
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = palette.foreground, bg = popup_bg })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = selected_bg, bg = popup_bg })
  vim.api.nvim_set_hl(0, "FloatTitle", { fg = palette.ansi[5], bg = popup_bg, bold = true })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = palette.foreground, bg = popup_bg })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = palette.foreground, bg = selected_bg })
  vim.api.nvim_set_hl(0, "PmenuKind", { fg = palette.ansi[5], bg = popup_bg })
  vim.api.nvim_set_hl(0, "PmenuExtra", { fg = palette.ansi[7], bg = popup_bg })
  vim.api.nvim_set_hl(0, "PmenuMatch", { fg = palette.ansi[3], bg = popup_bg, bold = true })
  vim.api.nvim_set_hl(0, "PmenuMatchSel", { fg = palette.ansi[3], bg = selected_bg, bold = true })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = palette.background })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = selected_bg })
  vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = palette.foreground, bg = selected_bg, bold = true })

  -- Keep comments and line numbers readable without competing with code.
  for _, group in ipairs({ "Comment", "@comment", "LineNr", "LineNrAbove", "LineNrBelow" }) do
    vim.api.nvim_set_hl(0, group, { fg = palette.ansi[9], ctermfg = 8, update = true })
  end
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.ansi[5], ctermfg = 4, update = true })

  for _, language in ipairs(require("xuantong.languages")) do
    for group, fg in pairs(require("xuantong.languages." .. language).groups(palette)) do
      vim.api.nvim_set_hl(0, group, { fg = fg })
    end
  end
end

return M

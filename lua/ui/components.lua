local M = {}

local u = require('ui.utils')

-- extract colors
local colors = {
  general = {
    normal = u.get_colors_from_hl('Normal').fg,
  },
  diagnostic = {
    error = u.get_colors_from_hl('DiagnosticsSignError').fg,
    warn = u.get_colors_from_hl('DiagnosticsSignWarn').fg,
    info = u.get_colors_from_hl('DiagnosticsSignInfo').fg,
    hint = u.get_colors_from_hl('DiagnosticsSignHint').fg,
  },
  git = {
  },
}

M.filename_diagnostic = function()
  local function count(buf, severity)
    return #vim.diagnostic.get(buf, { severity = severity })
  end

  local diagnostic_text = nil
  local fg = '#000000' -- TODO: temp value

  local e = count(0, vim.diagnostic.severity.ERROR)
  local w = count(0, vim.diagnostic.severity.WARN)
  local i = count(0, vim.diagnostic.severity.INFO)
  local h = count(0, vim.diagnostic.severity.HINT)
  if e > 0 then
    diagnostic_text = tostring(e)
    -- set fg to diagnostic fg
  elseif w > 0 then
    diagnostic_text = tostring(w)
  elseif i > 0 then
    diagnostic_text = tostring(i)
  elseif h > 0 then
    diagnostic_text = tostring(h)
  end
end

return M

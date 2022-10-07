local M = {}

function M.diagnostic_count(buf, severity)
  return #vim.diagnostic.get(buf, { severity = severity })
end

function M.get_colors_from_hl(highlight)
  return {
    fg = '',
    bg = '',
  }
end

return M

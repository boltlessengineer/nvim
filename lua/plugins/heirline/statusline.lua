local c = require("plugins.heirline.components")

return {
  -- c.git_status,
  c.space,
  c.diagnostics,
  c.space,
  c.lsp_list,
  c.align,
  c.space,
  hl = { fg = "stl_fg", bg = "stl_bg" },
}

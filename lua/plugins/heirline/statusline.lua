local c = require("plugins.heirline.components")

return {
  c.git_status,
  c.space,
  c.diagnostics,
  c.space2,
  c.lsp_list,
  c.align,
  -- c.last_messages,
  -- c.align,
  c.line_col,
  c.space2,
  c.tab_size,
  c.space2,
  c.file_enc,
  c.space2,
  c.file_format,
  c.space,
  hl = { fg = "stl_fg", bg = "stl_bg" },
}

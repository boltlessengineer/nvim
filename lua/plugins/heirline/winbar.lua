local c = require('plugins.heirline.components')

local defaultwinbar = {
  c.file_name_block,
  c.space,
  c.cutoff,
  c.navic,
  c.align,
}

return {
  fallthrough = false,
  defaultwinbar,
}

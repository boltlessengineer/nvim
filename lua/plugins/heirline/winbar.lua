local c = require('plugins.heirline.components')

-- SHOW FILENAME & git stuffs in tabline,
-- active winbar shows navic
-- inactive winbar shows filename

local defaultwinbar = {
  c.space,
  c.file,
  c.cutoff,
  c.navic,
  c.align,
}

return {
  fallthrough = false,
  defaultwinbar,
}

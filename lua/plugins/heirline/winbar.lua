local c = require('plugins.heirline.components')

-- SHOW FILENAME & git stuffs in tabline,
-- active winbar shows navic
-- inactive winbar shows filename
-- TODO: remove navic. navic uses too much space than it's usefulness

local defaultwinbar = {
  c.space,
  c.file,
  c.cutoff,
  c.navic,
  c.align,
  hl = { bg = 'normal_bg' },
}

return {
  fallthrough = false,
  defaultwinbar,
}

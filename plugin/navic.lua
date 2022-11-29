local ok, navic = pcall(require, 'nvim-navic')
if not ok then return end

navic.setup {
  icons = require('boltless.ui.icons').kind,
  highlight = true,
}

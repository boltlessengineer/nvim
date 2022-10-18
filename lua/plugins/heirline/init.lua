local ok, heirline = pcall(require, 'heirline')
if not ok then
  vim.opt.statusline = [[%{%v:lua.require('boltless.ui.statusline').get_no_plugin()%}]]
  vim.opt.winbar = [[%{%v:lua.require('boltless.ui.winbar').get_no_plugin()%}]]
  return
end

require('plugins.heirline.colors')
local c = require('plugins.heirline.components')

local statusline = {
  c.vi_mode,
  c.space,
  c.git,
  c.smartspace,
  c.diagnostics,
  c.align,
  c.tabstop,
  c.smartspace,
  c.file_info,
  c.smartspace,
  c.file_type,
  c.space,
}
-- TODO: remove this line
vim.opt.winbar = [[%{%v:lua.require('boltless.ui.winbar').get_no_plugin()%}]]

local winbar = {
  c.disable_winbar,
}
local tabline = {}

heirline.setup(statusline)

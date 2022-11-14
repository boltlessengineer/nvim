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
  c.diagnostics,
  c.align,
  c.tabstop,
  c.smartspace,
  c.file_info,
  c.smartspace,
  c.file_type,
  c.space,
}

-- IDEA: use tabline instead of winbar
-- winbar would only enabled for unfocused file buffers
-- tabline would contain focused filename, navic, tab count (like bufferline, but not including unfocused buffers)
-- this way, navic can have more spaces

local winbar = require('plugins.heirline.winbar')
-- TODO: tabline support
-- local tabline = {}

-- test function
--[[ function Statusline()
  return _G.GitStatus.head .. ' A' .. _G.GitStatus.ahead .. ' B' .. _G.GitStatus.behind
end

vim.opt.statusline = "%!luaeval('Statusline()')" ]]
heirline.setup(statusline, winbar)

require('autocmds.external').heirline()

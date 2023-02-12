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
  c.git,
  c.space,
  c.diagnostics,
  c.space,
  c.align,
  c.cutoff,
  c.lsp_client_names,
  c.space,
  c.etc,
  hl = { bg = 'bg' }
}

-- IDEA: use tabline instead of winbar
-- winbar would only enabled for unfocused file buffers
-- tabline would contain focused filename, navic, tab count (like bufferline, but not including unfocused buffers)
-- this way, navic can have more spaces

local winbar = require('plugins.heirline.winbar')

-- heirline.setup({
--   statusline = statusline,
--   winbar = winbar,
--   -- TODO: tabline support
--   -- tabline = tabline
-- })
-- require('lualine').setup({})

-- require('autocmds.external').heirline()

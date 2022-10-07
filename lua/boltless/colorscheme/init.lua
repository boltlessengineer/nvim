-- IDEA: time-based theme switch (see: https://github.com/abzcoding/lvim/commit/8c3f785d820107cff922360f1626e0d8004d5881#commitcomment-84750112)
vim.cmd [[let g:gruvbox_material_foreground = 'material']]
vim.cmd [[let g:gruvbox_material_better_performance = 1]]
-- Safe set colorscheme
-- local colorscheme = 'base16-gruvbox-material-dark-medium'
-- function try_colorscheme(colorscheme)
-- local ok = pcall(require('boltless.colorscheme.' .. colorscheme))
local c = require('kanagawa.colors').setup()
require('kanagawa').setup {
  overrides = {
    -- WinSeparator = { fg = c.sumiInk0, bg = c.sumiInk0 },
    WinSeparator = { fg = c.boatYellow1 --[[ , bg = c.oldWhite ]] },
    -- STNormalA = { fg = c.sumiInk0, bg = c.dragonBlue },
    -- STNormalB = { fg = c.crystalBlue, bg = c.winterBlue },
    -- STNormalC = { fg = dc.fg, bg = dc.crystalBlue },
    StatusLine = { fg = c.sumiInk0, bg = c.crystalBlue },
    -- StatusLine = { fg = c.fujiWhite, bg = c.sumiInk0 },
    -- STNormal = { fg = c.fujiWhite, bg = c.waveBlue2 },
    STNormal = { fg = c.crystalBlue, bold = true },
    STNormalB = { fg = c.dragonBlue, bg = c.waveBlue1 },
    -- StatusLine = { fg = c.lightBlue, bg = c.waveBlue1 },
    -- WinBar = { fg = c.sumiInk2, bg = c.waveAqua1 },
    WinBar = { fg = c.oldWhite, bg = c.sumiInk1 },
    WinBarTitle = { fg = c.sumiInk0, bg = c.oldWhite },
    -- WinBarTitle = { fg = c.sumiInk0, bg = c.boatYellow1 },
    WinBarNC = { fg = c.sumiInk4, bg = c.sumiInk0 },
  },
}
local colorscheme = 'kanagawa'
local ok = pcall(vim.cmd.colorscheme, colorscheme)
if not ok then
  vim.schedule(function()
    vim.notify('colorscheme ' .. colorscheme .. ' not found', 'error')
  end)
  -- return false
end
-- return true

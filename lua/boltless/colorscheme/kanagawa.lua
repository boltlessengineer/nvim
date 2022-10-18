local c = require('kanagawa.colors').setup()

require('kanagawa').setup {
  undercurl = true,
  commentStyle = {},
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { italic = true },
  typeStyle = {},
  variablebuiltinStyle = { italic = true },
  specialReturn = true,
  specialException = true,
  dimInactive = false,
  globalStatus = true,
  terminalColors = true,
  colors = {
    sumiInk5 = '#646482',
    -- TODO: more brighter color then sumiInk6
    sumiInk6 = '#717192',
  },
  overrides = {
    diffRemoved = { fg = c.peachRed },
    NvimTreeFolderIcon = { fg = c.crystalBlue },
    -- WinSeparator = { fg = c.sumiInk0 },
    -- StatusLine = { fg = c.fujiGray, bg = c.sumiInk0 },
    StatusLine = { fg = c.springViolet2, bg = c.sumiInk0 },
    -- WinBar = { fg = '#717192', bg = c.sumiInk0 },
    -- WinBarNC = { fg = c.sumiInk4, bg = c.sumiInk0 },
    WinBar = { link = 'StatusLine' },
    WinBarNC = { link = 'StatusLineNC' },

    Pmenu = { bg = c.sumiInk2 },
    PmenuSel = { link = 'Visual' },

    -- TODO: Navic colors
    -- TODO: LSP inline messages background color
  },
}

vim.cmd.colorscheme('kanagawa')

local c = require('kanagawa.colors').setup()

local isborder = (vim.g.borderstyle ~= 'none' and vim.g.borderstyle ~= 'solid')

c.sumiInk2c = '#252531'
c.sumiInk4b = '#434356'
c.sumiInk5  = '#6f6f90' -- reversed bg
local t     = {
  fg           = c.fujiWhite,
  bg           = c.sumiInk1, -- 14
  dim_bg       = c.sumiInk1, -- 14
  win_sep_fg   = c.sumiInk0, -- 19 (changed)
  win_sep_bg   = c.sumiInk0, -- 19 (changed)
  cursor_bg    = c.sumiInk2, -- 17 (changed)
  ref_text     = c.sumiInk4b, -- 24 (changed)
  float_bg     = c.sumiInk3, -- 24 (changed, alot)
  fold_bg      = c.sumiInk3, -- 22 (changed)
  colorcolumn  = c.sumiInk2c, -- 15 (changed)
  float_border = c.sumiInk4, -- 38
  sl_fg        = c.springViolet1, -- (changed)

  -- WIP : Pmenu
  menu_fg      = c.fujiWhite,
  menu_bg      = c.sumiInk3,
  menu_sel_fg  = c.fujiWhite,
  menu_sel_bg  = c.sumiInk4b,
  menu_sbar_fg = c.sumiInk4,
  menu_sbar_bg = c.sumiInk4b,
}
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
  },
  overrides = {
    Normal           = { fg = t.fg, bg = t.bg },
    NormalNC         = { fg = t.fg, bg = (vim.g.diminable and t.dim_bg or t.bg) },
    NormalFloat      = { fg = t.fg, bg = (isborder and t.bg or t.float_bg) },
    FloatBorder      = { fg = t.float_border, bg = (isborder and t.bg or t.float_bg) },
    CursorLine       = { bg = t.cursor_bg },
    LspReferenceText = { bg = t.ref_text },

    Folded       = { bg = t.fold_bg },
    ColorColumn  = { bg = t.colorcolumn },
    WinSeparator = { fg = t.win_sep_fg, bg = t.win_sep_bg },
    StatusLine   = { fg = t.sl_fg, bg = t.win_sep_fg },
    WinBar       = { fg = t.sl_fg, bg = t.win_sep_fg },
    WinBarNC     = { fg = t.float_border, bg = t.win_sep_fg },

    Pmenu      = { bg = t.menu_bg },
    PmenuSel   = { fg = t.menu_sel_fg, bg = t.menu_sel_bg },
    PmenuSbar  = { bg = t.menu_sbar_bg },
    PmenuThumb = { bg = t.menu_sbar_fg },
    -- CmpItemAbbrMatch = { fg = t.fg },
    -- CmpItemAbbrMatchDefault = { fg = t.fg, bold = true },
    -- CmpItemAbbrMatchFuzzy = { fg = t.fg },
    -- CmpItemAbbrMatchFuzzyDefault = { fg = t.fg, bold = true },
    -- Pmenu = { bg = c.sumiInk1 },
    -- PmenuSel = { link = 'Visual' },
    -- PmenuSbar = { link = 'Pmenu' }, -- scrollbar bg
    -- PmenuThumb = { bg = c.fujiWhite }, -- scrollbar fg

    TreesitterContextLineNumber = {},
    TreesitterContext = { bg = t.float_bg },
    TelescopeNormal = { link = 'NormalFloat' },
    TelescopeSelection = { link = 'PmenuSel' },
    TelescopeBorder = {
      fg = isborder and t.float_border or t.float_bg,
      bg = isborder and t.bg or t.float_bg,
    },

    -- just my favor
    -- TreesitterContextLineNumber = { fg = c.sumiInk4, bg = c.sumiInk2 }, -- bg from NormalFloat
    NvimTreeFolderIcon = { fg = c.crystalBlue },
    diffRemoved = { fg = c.peachRed },

    -- TODO: Navic colors
    -- TODO: diagnostic inline messages background color
  },
}

vim.cmd.colorscheme('kanagawa')

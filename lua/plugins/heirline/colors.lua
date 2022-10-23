local utils = require('heirline.utils')

local function setup_colors()

  local colors = {
    red              = vim.g.terminal_color_1,
    green            = vim.g.terminal_color_2,
    yellow           = vim.g.terminal_color_3,
    blue             = vim.g.terminal_color_4,
    magenta          = vim.g.terminal_color_5,
    cyan             = vim.g.terminal_color_6,
    white            = vim.g.terminal_color_7,
    bright_black     = vim.g.terminal_color_8,
    bright_red       = vim.g.terminal_color_9,
    bright_green     = vim.g.terminal_color_10,
    bright_yellow    = vim.g.terminal_color_11,
    bright_blue      = vim.g.terminal_color_12,
    bright_magenta   = vim.g.terminal_color_13,
    bright_cyan      = vim.g.terminal_color_14,
    bright_white     = vim.g.terminal_color_15,
    extended_color_1 = vim.g.terminal_color_16,
    extended_color_2 = vim.g.terminal_color_17,

    diag_warn = utils.get_highlight('DiagnosticWarn').fg,
    diag_error = utils.get_highlight('DiagnosticError').fg,
    diag_hint = utils.get_highlight('DiagnosticHint').fg,
    diag_info = utils.get_highlight('DiagnosticInfo').fg,
    -- git_del = utils.get_highlight('diffDeleted').fg,
    -- git_add = utils.get_highlight('diffAdded').fg,
    -- git_change = utils.get_highlight('diffChanged').fg,
  }

  colors.fg = utils.get_highlight('StatusLine').fg
  -- TODO: create `dark_fg` color by darken fg with bg
  colors.dark_fg = utils.get_highlight('FloatBorder').fg
  colors.bg = utils.get_highlight('StatusLine').bg
  -- colors.sep = utils.get_highlight('CursorLine').bg

  -- local kanagawa = require('kanagawa.colors').setup()
  -- colors = vim.tbl_extend('keep', colors, kanagawa)
  return colors
end

require('heirline').load_colors(setup_colors())

-- TODO move codes below to autocmd/external
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    local colors = setup_colors()
    utils.on_colorscheme(colors)
  end
})

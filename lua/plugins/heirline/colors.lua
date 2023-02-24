local utils = require("heirline.utils")
local get_hl = utils.get_highlight

local lualine = require("lualine.themes." .. vim.g.colors_name)
return {
  load_colors = function()
    -- stylua: ignore
    require('heirline').load_colors({
      fg         = get_hl('Normal').fg,
      bg         = get_hl('Normal').bg,
      stl_fg     = get_hl("StatusLine").fg,
      stl_bg     = get_hl("StatusLine").bg,
      stl_nc_fg  = get_hl("StatusLineNC").fg,
      stl_nc_bg  = get_hl("StatusLineNC").bg,
      wbr_fg     = get_hl('WinBar').fg,
      wbr_bg     = get_hl('WinBar').bg,
      wbr_nc_fg  = get_hl('WinBarNC').fg,
      wbr_nc_bg  = get_hl('WinBarNC').bg,
      vi_normal  = get_hl('CursorLineNr').fg,
      vi_visual  = lualine and lualine.visual.a.bg,
      vi_insert  = vim.g.terminal_color_2, -- green
      vi_select  = vim.g.terminal_color_1, -- red
      vi_command = lualine and lualine.command.a.bg,
      diag_warn  = get_hl('DiagnosticWarn').fg,
      diag_error = get_hl('DiagnosticError').fg,
      diag_hint  = get_hl('DiagnosticHint').fg,
      diag_info  = get_hl('DiagnosticInfo').fg,
      git_del    = get_hl('GitsignsDelete').fg,
      git_add    = get_hl('GitsignsAdd').fg,
      git_change = get_hl('GitsignsChange').fg,
      comment    = get_hl('@comment').fg,
      conceal    = get_hl("Conceal").fg,
      nontext    = get_hl("NonText").fg,
      section    = lualine and lualine.normal.b.bg,
    })
  end,
}

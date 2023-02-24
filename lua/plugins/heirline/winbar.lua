local c = require("plugins.heirline.components")
local cond = require("heirline.conditions")

local normal = {
  c.vi_mode,
  {
    condition = cond.is_not_active,
    c.make_space(5),
  },
  c.space,
  c.space,
  c.filename_block,
  -- { provider = "  12" },
  c.space,
  c.local_diagnostics,
  c.align,
  -- { provider = "%-14.(%l,%c%V%)%P" },
  c.space,
}

local terminal = {
  condition = function()
    return cond.buffer_matches({
      buftype = { "prompt", "help", "quickfix", "terminal" },
    })
  end,
  c.vi_mode,
  {
    condition = cond.is_not_active,
    c.make_space(5),
  },
  c.align,
  {
    provider = function()
      return vim.bo.buftype
    end,
  },
  c.align,
  c.make_space(5),
}

return {
  fallthrough = false,
  terminal,
  normal,
  hl = function()
    if cond.is_active() then
      return { fg = "wbr_fg", bg = "wbr_bg" }
    else
      return { fg = "wbr_nc_fg", bg = "wbr_nc_bg" }
    end
  end,
}

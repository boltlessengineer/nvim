local M = {
  palette = {},
}

-- stylua: ignore

---Color palette from base16 colors
local function set_pallete()
  M.palette = {
    red        = vim.g.terminal_color_1 or "red",
    green      = vim.g.terminal_color_2 or "green",
    yellow     = vim.g.terminal_color_3 or "yellow",
    blue       = vim.g.terminal_color_4 or "blue",
    magenta    = vim.g.terminal_color_5 or "magenta",
    cyan       = vim.g.terminal_color_6 or "cyan",
    white      = vim.g.terminal_color_7 or "white",

    -- TODO: if same with above, automatically adjust the colors
    br_red     = vim.g.terminal_color_9,
    br_green   = vim.g.terminal_color_10,
    br_yellow  = vim.g.terminal_color_11,
    br_blue    = vim.g.terminal_color_12,
    br_magenta = vim.g.terminal_color_13,
    br_cyan    = vim.g.terminal_color_14,
    br_white   = vim.g.terminal_color_15,
  }
end

set_pallete()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("config_palette", { clear = true }),
  callback = function()
    vim.defer_fn(function()
      set_pallete()
    end, 1)
  end,
})

return M

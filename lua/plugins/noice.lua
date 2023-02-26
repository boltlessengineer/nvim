return {
  "folke/noice.nvim",
  dependencies = {
    { "smjonas/inc-rename.nvim", config = true },
    {
      "rcarriga/nvim-notify",
      opts = {
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { focusable = false })
        end,
      },
    },
  },
  opts = {
    lsp = {
      override = {
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      inc_rename = true,
      -- cmdline_output_to_split = true,
    },
    messages = {
      -- view = "notify",
      -- view_search = false,
    },
  },
}

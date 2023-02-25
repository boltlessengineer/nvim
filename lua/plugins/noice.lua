return {
  "folke/noice.nvim",
  dependencies = {
    { "smjonas/inc-rename.nvim", config = true },
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

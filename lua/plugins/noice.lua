return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      override = {
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      -- cmdline_output_to_split = true,
    },
    messages = {
      -- view = "notify",
      -- view_search = false,
    },
  },
}

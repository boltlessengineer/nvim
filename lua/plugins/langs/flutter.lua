-- TODO: flutter setup
--
-- see: https://github.com/papitz/nvim/tree/c59ece6e9a6fe6ac478d4113ad7b29df712eab6b
return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "dart",
    enabled = false,
    opts = {
      widget_guides = {
        enabled = true,
      },
    },
    config = function(_, opts)
      require("flutter-tools").setup(opts)
    end,
  },
  -- TODO: flutter snippets
  { "Neevash/awesome-flutter-snippets", enabled = false },
  { "RobertBrunhage/flutter-riverpod-snippets", enabled = false }, -- copied from akinsho's dotfiles
}

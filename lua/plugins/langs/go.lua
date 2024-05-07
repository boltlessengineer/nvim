return {
  "ray-x/go.nvim",
  enabled = false,
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter"
  },
  opts = {
    disable_defaults = true,
  },
  -- config = function ()
  --   require("go").setup()
  -- end,
  build = ":lua require('go.install').update_all_sync()",
}

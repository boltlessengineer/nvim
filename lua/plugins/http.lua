return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config  = true,
    -- opts = {
    --   luarocks_build_args = {
    --     "--with-lua-include=/usr/include",
    --   },
    -- },
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = {
      "luarocks.nvim",
      -- {
      --   "nvim-treesitter/nvim-treesitter",
      --   config = function (_, opts)
      --   end,
      -- }
    },
    config = function()
      require("rest-nvim").setup()
    end,
  },
}

return {
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    -- TODO: cargo-update command (<leader>cu)
    config = true,
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      vim.list_extend(
        opts.sources,
        cmp.config.sources({
          { name = "crates" },
        })
      )
    end,
  },
}

return {
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      src = { cmp = { enabled = true } },
      on_attach = function(bufnr)
        local crates = require("crates")
        -- overwrite `K` mapping
        vim.keymap.set({ "n", "x" }, "K", function()
          if crates.popup_available() then
            crates.show_crate_popup()
          else
            vim.lsp.buf.hover()
          end
        end, {
          desc = "Hover",
          buffer = bufnr,
          silent = true,
        })
      end,
    },
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

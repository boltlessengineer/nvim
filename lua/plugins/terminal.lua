return {
  {
    "boltlessengineer/bufterm.nvim",
    dev = true,
    opts = {
      debug = false,
      terminal = {
        buflisted = true,
      },
    },
    keys = {
      { mode = "t", "<C-o>", "<cmd>BufTermPrev<CR>", desc = "Prev Terminal" },
      { mode = "t", "<C-i>", "<cmd>BufTermNext<CR>", desc = "Next Terminal" },
      { [[\\]], "<cmd>BufTermEnter<CR>" },
      {
        mode = { "n", "t" },
        "<c-t>",
        function()
          if require("bufterm.ui").toggle_float() then
            vim.cmd("BufTermEnter")
          end
        end,
        desc = "Toggle floating terminal",
      },
    },
  },
}

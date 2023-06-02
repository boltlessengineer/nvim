return {
  "folke/which-key.nvim",
  keys = { "<leader>", "]", "[", "m" },
  opts = {
    plugins = {
      marks = false,
      registers = true,
      spelling = false,
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = true,
        g = false,
      },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register({
      mode = "n",
      ["<leader>d"] = { name = "+debug" },
      ["<leader>t"] = { name = "+test" },
      ["<leader>r"] = { name = "+refactor" },
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>o"] = { name = "+options" },
    })
    wk.register({
      mode = { "n", "v" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["m"] = { name = "+match" },
    })
  end,
}

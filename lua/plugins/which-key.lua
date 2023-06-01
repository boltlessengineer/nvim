return {
  "folke/which-key.nvim",
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
      mode = { "n" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>o"] = { name = "+options" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["m"] = { name = "+match" },
    })
  end,
}

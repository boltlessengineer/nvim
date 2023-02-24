local Util = require("lazyvim.util")
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
    local keymaps = {
      mode = { "n" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>o"] = { name = "+options" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
      ["m"] = { name = "+match" },
    }
    if Util.has("noice.nvim") then
      keymaps["<leader>sn"] = { name = "+noice" }
    end
    wk.register(keymaps)
  end,
}

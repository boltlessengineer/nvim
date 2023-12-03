return {
  "folke/which-key.nvim",
  event = "VeryLazy",
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
    vim.api.nvim_create_autocmd("CmdWinEnter", {
      group = vim.api.nvim_create_augroup("DisableWhichKey", { clear = true }),
      callback = function(e)
        vim.keymap.set("n", "<leader>", "<nop>", { buffer = e.buf })
        vim.keymap.set("n", "]", "<nop>", { buffer = e.buf })
        vim.keymap.set("n", "[", "<nop>", { buffer = e.buf })
        vim.keymap.set("n", "m", "<nop>", { buffer = e.buf })
        vim.keymap.set("n", "<c-g>", "<nop>", { buffer = e.buf })
      end,
    })
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
      ["<c-g>"] = { name = "+chatgpt" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["m"] = { name = "+match" },
    })
  end,
}

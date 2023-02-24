-- TODO: ignore deleted files in git_files view
-- see :h telescope.builtins.git_files and `git ls-files --help`
-- maybe changing command to `git ls-files --exclude-standard --modified --others --stage` will work
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<F1>", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>,", false }, -- switch buffer
      { "<leader>:", false }, -- command history
      { "<leader>sb", false }, -- buffer
      { "<leader>sc", false }, -- command history
      { "<leader>sC", false }, -- commands
      { "<leader>sm", false }, -- makr
      { "<leader>so", false }, -- options
      { "<leader>sw", false }, -- word (root dir)
      { "<leader>sW", false }, -- word (cwd)
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      local imaps = opts.defaults.mappings.i
      imaps["<a-i>"] = false
      imaps["<a-h>"] = false
      imaps["<C-Down>"] = false
      imaps["<C-Up>"] = false
      imaps["<C-f>"] = false
      imaps["<C-b>"] = false
      imaps["<c-x>"] = false
      imaps["<c-s>"] = actions.select_horizontal
      imaps["<c-t>"] = actions.select_tab
      imaps["<ESC>"] = actions.close
      imaps["<c-c>"] = actions.close
    end,
  },
}

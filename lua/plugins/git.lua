return {
  -- general git jobs
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
  },
  {
    "lewis6991/gitsigns.nvim",
    -- TODO: add red underline in init() function
    opts = {
      -- stylua: ignore
      signs = {
        add          = { text = "│" }, -- or ┃,▎
        change       = { text = "│" },
        delete       = { text = "▁" },
        topdelete    = { text = "▔" },
        changedelete = { text = "│" }, -- with underline ;)
        untracked    = { text = "┆" },
      },
    },
  },
  -- better diffing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
    },
  },
}

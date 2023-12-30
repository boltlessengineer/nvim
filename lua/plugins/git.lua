return {
  -- general git jobs
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    dependencies = "sindrets/diffview.nvim",
    opts = {
      kind = "tab",
      integrations = {
        diffview = true,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    _keys = {
      { "ih", ":<c-u>Gitsigns select_hunk<cr>", mode = { "o", "x" }, desc = "Select Hunk" },
      { "ah", ":<c-u>Gitsigns select_hunk<cr>", mode = { "o", "x" }, desc = "Select Hunk" },
      { "]h", "<cmd>Gitsigns next_hunk<cr>", mode = { "n", "x" }, desc = "Next Hunk" },
      { "[h", "<cmd>Gitsigns prev_hunk<cr>", mode = { "n", "x" }, desc = "Prev Hunk" },
      { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
      { "<leader>gA", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage Buffer" },
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset Buffer" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Preview Inline" },
      { "<leader>gP", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line" },
      { "<leader>ga", "<cmd>Gitsigns stage_hunk<cr>", mode = { "n", "x" }, desc = "Stage Hunk" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", mode = { "n", "x" }, desc = "Reset Hunk" },
    },
    event = "VeryLazy",
    opts = function(plugin, _)
      return {
        -- FIX: enable staged signs
        _signs_staged_enable = false,
        -- stylua: ignore
        _signs_staged = {
          changedelete = { text = "┃" }, -- with underline ;)
        },
        -- stylua: ignore
        signs = {
          -- useful signs: ┃▎│┆
          add          = { text = "┃" },
          change       = { text = "┃" },
          delete       = { text = "▁" },
          topdelete    = { text = "▔" },
          changedelete = { text = "┃" }, -- with underline ;)
          untracked    = { text = " " },
        },
        on_attach = function(buffer)
          require("utils").attach_keymaps(buffer, plugin._keys)
          -- TODO: more git mappings
          -- <leader>gc : commit
          -- <leader>gL : lazygit
        end,
      }
    end,
  },
  -- better diffing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {
      use_icons = false,
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
    },
  },
}

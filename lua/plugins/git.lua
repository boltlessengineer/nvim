return {
  -- general git jobs
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
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
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
        end
        local no = "n"
        local nv = { "n", "v" }
        local ox = { "o", "x" }

        -- TODO: use require('utils').attach_keymaps

        -- stylua: ignore start
        map(ox, "ih", ":<C-U>Gitsigns select_hunk<cr>", "GitSigns Select Hunk")
        map(no, "]h", gs.next_hunk, "Next Hunk")
        map(no, "[h", gs.prev_hunk, "Prev Hunk")
        map(no, "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map(nv, "<leader>ga", "<cmd>Gitsigns stage_hunk<CR>", "Stage Hunk")
        map(nv, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk")
        map(no, "<leader>gA", gs.stage_buffer, "Stage Buffer")
        map(no, "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map(no, "<leader>gp", gs.preview_hunk_inline, "Preview Inline")
        map(no, "<leader>gP", gs.preview_hunk, "Preview Hunk")
        map(no, "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        -- TODO: more git mappings
        -- <leader>gc : commit
        -- <leader>gL : lazygit
      end,
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

---@type LazySpec[]
return {
  -- buffer style folder view
  {
    "stevearc/oil.nvim",
    opts = {
      keymaps = {
        ["g?"] = false,
        ["<C-/>"] = "actions.show_help",
        ["<C-s>"] = "actions.select_split",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-r>"] = false,
        ["<C-l>"] = "actions.refresh",
        ["<C-.>"] = "actions.toggle_hidden",
      },
    },
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
  -- highlight search only while n/N typed
  {
    "asiryk/auto-hlsearch.nvim",
    event = "VeryLazy",
    opts = {
      remap_keys = { "/", "?", "*", "#", "n", "N" },
      create_commands = true,
      post_hook = function()
        -- HACK: clear noice search count messages
        vim.cmd([[normal! :<CR>]])
      end,
    },
    -- wrap with schedule to load *after* `config.keymaps`
    config = vim.schedule_wrap(function(_, opts)
      require("auto-hlsearch").setup(opts)
    end),
  },
  -- immediate visual feedback for `:norm` command
  {
    "smjonas/live-command.nvim",
    event = "VeryLazy",
    opts = {
      commands = {
        Norm = { cmd = "norm" },
      },
    },
    config = function(_, opts)
      require("live-command").setup(opts)
    end,
  },
  -- smart split/join codes based on tree-sitter
  {
    -- TODO: need way to split empty function in lua
    -- e.g. `function() end`.
    -- `function_definition` capture group
    "Wansmer/treesj",
    keys = {
      { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 150,
    },
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      signs = false,
    },
    config = function(_, opts)
      require("todo-comments").setup(opts)
    end,
  },
}

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
    dev = true,
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
    -- TODO: support `J` in mutli-line @comments like builtin J works
    -- TODO: in @comments (which is at end of line, not new line), move comment to prev line
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
      { "<A-j>", "J", desc = "Join (builtin)" },
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

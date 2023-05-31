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
  {
    "cbochs/grapple.nvim",
    keys = {
      { "<leader>h", desc = "Grapple" },
      { "<leader><leader>", "<cmd>GrapplePopup tags<cr>", desc = "Grapple Tags" },
      { "<leader>hs", "<cmd>GrapplePopup scopes<cr>", desc = "Popup scopes" },
      { "<leader>hp", "<cmd>GrappleTag<cr>", desc = "Pin File" },
    },
  },
  -- highlight search only while n/N typed
  {
    "asiryk/auto-hlsearch.nvim",
    enabled = false,
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
    "nvim-pack/nvim-spectre",
    keys = {
      { "<leader>sr", "<cmd>lua require('spectre').open()<cr>", desc = "Spectre" },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    opts = {
      signs = false,
    },
    -- stylua: ignore
    keys = {
      { "]t", function () require('todo-comments').jump_next() end, desc = "Next Todo" },
      { "[t", function () require('todo-comments').jump_prev() end, desc = "Prev Todo" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "ToDo" },
    },
  },
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      opts = function(_, opts)
        opts.extensions = opts.extensions or {}
        opts.extensions.aerial = {
          show_nesting = {
            ["_"] = false,
            json = true,
            yaml = true,
            toml = true,
          },
        }
      end,
    },
    keys = {
      { "<leader>co", "<cmd>Telescope aerial<cr>", desc = "Code Outline" },
      { "}", "<cmd>AerialNext<cr>", "Next kind" },
      { "{", "<cmd>AerialPrev<cr>", "Prev kind" },
    },
    opts = function(plugin, _)
      return {
        on_attach = function(bufnr)
          require("utils").attach_keymaps(bufnr, plugin.keys)
        end,
      }
    end,
    config = function(_, opts)
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("aerial")
      end
      require("aerial").setup(opts)
    end,
  },
}

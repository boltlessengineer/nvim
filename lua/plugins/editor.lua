local Util = require("utils")
---@type LazySpec[]
return {
  -- buffer style folder view
  {
    "stevearc/oil.nvim",
    -- disable lazy loading to load oil on `vim [folder]`
    event = "VimEnter",
    keys = {
      -- stylua: ignore
      { "_", function () vim.cmd.edit(Util.root()) end, desc = "Open root dir" },
      { "-", "<cmd>Oil<cr>" },
    },
    opts = {
      -- stylua: ignore
      keymaps = {
        -- TODO: put a small note that I can use `g?` for help
        -- TODO: change `_` opens Oil in util.root()
        -- and make it global keymap
        ["<C-/>"] = "actions.show_help",
        ["<C-s>"] = "actions.select_split",
        ["<C-v>"] = "actions.select_vsplit",
        ["K"]     = "actions.preview",
        ["<C-l>"] = "actions.refresh",
        ["<C-.>"] = "actions.toggle_hidden",
        ["-"]     = "actions.parent",
        ["_"]     = false,
        ["<c-h>"] = false,
        ["<c-p>"] = false,
      },
    },
  },
  "nacro90/numb.nvim",
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
      { "<leader>h", desc = "+harppon" },
      { "<leader><leader>", "<cmd>GrapplePopup tags<cr>", desc = "Grapple Tags" },
      { "<leader>hs", "<cmd>GrapplePopup scopes<cr>", desc = "Popup scopes" },
      { "<leader>hp", "<cmd>GrappleTag<cr>", desc = "Pin File" },
      { "<leader>1", "<cmd>GrappleSelect key=1<cr>", desc = "Pin 1" },
      { "<leader>2", "<cmd>GrappleSelect key=2<cr>", desc = "Pin 2" },
      { "<leader>3", "<cmd>GrappleSelect key=3<cr>", desc = "Pin 3" },
      { "<leader>4", "<cmd>GrappleSelect key=4<cr>", desc = "Pin 4" },
    },
  },
  -- highlight search only while n/N typed
  -- TODO: move to ui.lua
  {
    -- TODO: also diable highlights on CmdLineLeave for search-replace situation
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
    -- TODO: affraid I'll forget this useful command
    -- I can use `:[range]Norm` for immediate feedbacks
    "smjonas/live-command.nvim",
    event = "CmdLineEnter",
    main = "live-command", -- remove annoying "name depreciated" message
    opts = {
      commands = {
        Norm = { cmd = "norm" },
      },
    },
  },
  -- smart split/join codes based on tree-sitter
  {
    -- TODO: need way to split empty function in lua
    -- e.g. `function() end`.
    -- `function_definition` capture group
    -- TODO: abbrev
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
      highlight = {
        multiline = true,
        multiline_context = 5,
      },
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
      opts = {
        extensions = {
          aerial = {
            show_nesting = {
              ["_"] = false,
              json = true,
              yaml = true,
              toml = true,
            },
          },
        },
      },
    },
    keys = {
      { "<leader>co", "<cmd>Telescope aerial<cr>", desc = "Code Outline" },
      { "]]", "<cmd>AerialNext<cr>", desc = "Next kind" },
      { "[[", "<cmd>AerialPrev<cr>", desc = "Prev kind" },
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

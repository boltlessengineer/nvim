return {
  -- nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
    config = function(_, opts)
      local ap = require("nvim-autopairs")
      -- TODO: add rust closure mappings (see: https://www.reddit.com/r/neovim/comments/13mwkij/comment/jkxidam/?utm_source=share&utm_medium=web2x&context=3)
      ap.setup(opts)
    end,
  },
  -- comment
  {
    "numToStr/Comment.nvim",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
          opts = {
            context_commentstring = {
              enable = true,
              enable_autocmd = false,
            },
          },
        },
      },
    },
    keys = {
      { "g/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment Linewise" },
      { "<C-/>", "<Plug>(comment_toggle_linewise_current)", desc = "Comment Linewise" },
      { "<C-?>", "<Plug>(comment_toggle_blockwise_current)", desc = "Comment Blockwise" },
      { mode = "x", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment Linewise" },
      { mode = "x", "<C-?>", "<Plug>(comment_toggle_blockwise_visual)", desc = "Comment Blockwise" },
    },
    opts = function()
      return {
        mappings = {
          basic = false,
          extra = false,
        },
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  -- surround
  {
    "kylechui/nvim-surround",
    opts = {
      -- stylua: ignore
      keymaps = {
        insert          = false,
        insert_line     = false,
        normal          = "ms",
        normal_cur      = false,
        normal_line     = false,
        normal_cur_line = false,
        visual          = "ms",
        visual_line     = false,
        change          = "mr",
        delete          = "md",
      },
    },
  },
  -- easy align
  {
    "junegunn/vim-easy-align",
    keys = {
      { mode = "x", "ga", "<plug>(EasyAlign)", desc = "Align selection" },
    },
  },
}

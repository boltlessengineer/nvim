return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
    config = function(_, opts)
      local ap = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      -- TODO: add rust closure mappings (see: https://www.reddit.com/r/neovim/comments/13mwkij/comment/jkxidam/?utm_source=share&utm_medium=web2x&context=3)

      ap.setup(opts)

      -- add spaces between brackets
      local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
      local brackets_str = {}
      local brackets_str_space = {}
      for _, bracket in ipairs(brackets) do
        table.insert(brackets_str, bracket[1] .. bracket[2])
        table.insert(brackets_str_space, bracket[1] .. "  " .. bracket[2])
      end
      -- stylua: ignore
      ap.add_rule(
        Rule(" ", " ")
          :with_pair(function(o)
            local pair = o.line:sub(o.col - 1, o.col)
            return vim.tbl_contains(brackets_str, pair)
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(o)
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local context = o.line:sub(col - 1, col + 2)
            return vim.tbl_contains(brackets_str_space, context)
          end)
      )
      for _, bracket in ipairs(brackets) do
        ap.add_rule(Rule("", " " .. bracket[2])
          :with_pair(cond.none())
          :with_move(function(o)
            return o.char == bracket[2]
          end)
          :with_cr(cond.none())
          :with_del(cond.none())
          :use_key(bracket[2]))
      end
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

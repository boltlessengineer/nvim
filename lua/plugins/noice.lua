local enable_ext_mess = false

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "smjonas/inc-rename.nvim",
    { "rcarriga/nvim-notify", lazy = true },
  },
  cond = function()
    return not vim.g.neovide
  end,
  -- stylua: ignore
  keys = {
    { "<c-d>", function() if not require("noice.lsp").scroll(4) then return "<c-d>" end end, silent = true, expr = true, desc = "Scroll down", mode = {"i", "n", "s"} },
    { "<c-u>", function() if not require("noice.lsp").scroll(-4) then return "<c-u>" end end, silent = true, expr = true, desc = "Scroll up", mode = {"i", "n", "s"} },
  },
  ---@type NoiceConfig
  opts = {
    cmdline = {
      enabled = enable_ext_mess,
      format = {
        filter = false, -- desable default :! format
        shell = { pattern = "^:%s*!", icon = "$", lang = string.match(vim.o.shell, "[^/]+$") },
        lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
        Lua_Print = { pattern = { "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
        search_replace = {
          pattern = { "^:%%?s/" },
          kind = "search",
          view = "cmdline",
          icon = "s/",
          lang = "regex",
        },
      },
    },
    messages = {
      enabled = enable_ext_mess,
      view = "mini",
      view_error = "mini",
      view_warn = "mini",
      view_history = "messages",
      view_search = "virtualtext",
    },
    popupmenu = { enabled = enable_ext_mess },
    redirect = {},
    commands = {
      all = {
        view = "split",
        opts = { enter = true, format = "details" },
        filter = {},
      },
    },
    notify = { enabled = false },
    lsp = {
      progress = {
        enabled = false,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = { enabled = true },
      signature = {
        auto_open = {
          enabled = false,
          luasnip = true,
        },
      },
      message = { enabled = false },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = false, -- implemented my own
      inc_rename = true,
      lsp_doc_border = false,
    },
    views = {
      -- cmdline_popup = {
      --   border = {
      --     style = "none",
      --     padding = { 1, 3 },
      --   },
      --   win_options = {
      --     winhighlight = {
      --       NormalFloat = "NormalFloat",
      --       FloatBorder = "FloatBorder",
      --     },
      --   },
      -- },
      mini = {
        align = "message-left",
        position = {
          row = -1,
          col = 0,
        },
        win_options = {
          winblend = 0,
          winhighlight = {
            Normal = "NoiceMini",
          },
        },
      },
      virtualtext = {
        close = {
          events = { "CursorMoved" },
        },
      },
    },
    ---@type NoiceRouteConfig[]
    routes = {
      { -- long messages to split
        filter = {
          event = "msg_show",
          min_height = 2,
          ["not"] = { kind = { "confirm", "confirm_sub" } },
        },
        view = "split",
      },
      { -- long messages to split
        filter = {
          event = "msg_show",
          max_height = 1,
          ["not"] = { kind = { "confirm", "confirm_sub" } },
        },
        opts = { replace = true },
      },
      { -- skip search messages
        filter = {
          event = "msg_show",
          kind = "",
          any = {
            { find = "^/.+" },
          },
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "%d+ lines yanked" },
            { find = "%d+ fewer line" },
            { find = "%d+ more line" },
            { find = "%d+ line" },
            { find = '".+" %d+l, %d+b' },
            { find = " #%d+%s+%d+ seconds? ago" },
            { find = "; after #%d+%s+" },
            { find = "; before #%d+%s+" },
            { find = "--No lines in buffer--" },
            { find = "%d+ substitutions on %d+ line" },
            { find = "Already at newest change" },
            { find = "^E486:" },
          },
        },
        view = "mini",
        opts = { replace = true },
      },
      {
        filter = {
          any = {
            { event = "msg_show", find = "^Hunk %d+ of %d+" },
          },
        },
        -- HACK: virtualtext is buggy (can't remove automatically)
        view = "mini",
      },
    },
  },
}

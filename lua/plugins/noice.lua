return {
  "folke/noice.nvim",
  enabled = false,
  dependencies = {
    "smjonas/inc-rename.nvim",
    "rcarriga/nvim-notify",
  },
  init = function()
    vim.opt.cmdheight = 0
  end,
  ---@type NoiceConfig
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            find = "%d+L, %d+B",
          },
          view = "mini",
        },
      },
      signature = {
        auto_open = {
          trigger = false,
        },
      },
    },
    presets = {
      inc_rename = true,
      -- cmdline_output_to_split = true,
    },
    messages = {
      -- view = "notify",
      -- view_search = false,
    },
  },
}

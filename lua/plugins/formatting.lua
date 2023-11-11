local Util = require("utils")

return {
  {
    -- TODO:
    -- copy from LazyVim
    -- formatting.lua
    -- util/format.lua
    -- util/root.lua
    -- remove lsp/format.lua
    "stevearc/conform.nvim",
    lazy = true,
    cmd = "ConformInfo",
    init = function()
      -- Register the conform formatter on VeryLazy
      Util.plugin.on_very_lazy(function()
        Util.format.register({
          name = "conform.nvim",
          priority = 100,
          primary = true,
          format = function(buf)
            local plugin = require("lazy.core.config").plugins["conform.nvim"]
            local Plugin = require("lazy.core.plugin")
            local opts = Plugin.values(plugin, "opts", false)
            require("conform").format(Util.merge(opts.format, { bufnr = buf }))
          end,
          sources = function(buf)
            local ret = require("conform").list_formatters(buf)
            ---@param v conform.FormatterInfo
            return vim.tbl_map(function(v)
              return v.name
            end, ret)
          end,
        })
      end)
    end,
    opts = {
      format = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        prettierd = {
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc.json"),
          },
        },
      },
    },
  },
}

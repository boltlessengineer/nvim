---@type LazyPluginSpec[]
return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(keys, {
        { "gK", false }, -- signature help (just hover is ok)
        { "<leader>cl", false },
      })
    end,
    opts = {
      diagnostics = {
        virtual_text = false,
        virtual_lines = false,
      },
      ---@type lspconfig.options
      servers = {
        clangd = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false, -- use stylua istead
              },
            },
          },
        },
        gopls = {},
        rust_analyzer = {},
      },
    },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "VeryLazy",
    -- TODO: PR: use config.virtual_lines.enable to use with one_current_line
    -- support API like `show_current_line()`
    config = true,
    keys = {
      {
        "<leader>cl",
        function()
          require("lsp_lines").toggle()
        end,
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dev = false,
  },
  {
    "joechrisellis/lsp-format-modifications.nvim",
    lazy = true,
    enabled = false,
    opts = {
      format_on_save = false,
    },
    init = function(_, opts)
      require("lazyvim.util").on_attach(function(client, buffer)
        if client.supports_method("textDocument/rangeFormatting") then
          require("lsp-format-modifications").attach(client, buffer, opts)
          -- TODO: setup modification format
        end
      end)
      -- TODO: lsp-format-modi should also be attached in null-ls' on_attach functions
    end,
    config = function() end,
  },
}

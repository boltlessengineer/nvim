return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(keys, {
        { "gK", false }, -- signature help (just hover is ok)
      })
    end,
    opts = {
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

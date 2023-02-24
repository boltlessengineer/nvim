---@type LazyPluginSpec[]
return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      vim.list_extend(keys, {
        { "gK", false }, -- signature help (just hover is ok)
        { "<leader>cl", false },
        { "<leader>cm", false },
        { "<leader>cI", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
        { "<leader>cM", "<cmd>Mason<cr>", desc = "Mason" },
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
        cssls = {},
        tsserver = {},
        svelte = {},
        html = {},
        gopls = {},
        pyright = {},
        rust_analyzer = {},
        yamlls = {},
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
        desc = "Toggle diagnostics",
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dev = false,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      require("lazyvim.util").on_attach(function(client, buffer)
        -- this checks inlayHintProvider capability automatically
        require("lsp-inlayhints").on_attach(client, buffer)
      end)
    end,
  },
  {
    "joechrisellis/lsp-format-modifications.nvim",
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

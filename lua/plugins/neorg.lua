return {
  {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    enabled = false,
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
      parser_configs.norg = {
        install_info = {
          url = "https://github.com/nvim-neorg/tree-sitter-norg2",
          files = { "src/parser.c", "src/scanner.cc" },
          revision = "main",
        },
      }
      require("neorg").setup(opts)
    end,
    opts = {
      load = {
        ["core.defaults"] = {},
        -- ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.keybinds"] = {
          config = {
            hook = function(keybinds)
              keybinds.remap_key("norg", "i", "<M-CR>", "<S-CR>")
            end,
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}

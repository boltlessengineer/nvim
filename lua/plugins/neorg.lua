return {
  {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    -- enabled = false,
    build = ":Neorg sync-parsers",
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
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
            default_keybinds = false,
            hook = function(keybinds)
              keybinds.remap_key("norg", "i", "<M-CR>", "<S-CR>")
            end,
          },
        },
        ["core.esupports.indent"] = {
          config = {
            format_on_enter = false,
            format_on_escape = false,
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}

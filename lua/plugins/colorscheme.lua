return {
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "kvrohit/mellow.nvim", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "JoosepAlviste/palenightfall.nvim", lazy = true },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      term_colors = true,
      highlight_overrides = {
        all = function(c)
          local winsep = c.crust
          return {
            NonText = { fg = c.surface0 },
            TabLineFill = { fg = c.overlay2 },
            VertSplit = { fg = winsep },
            WinBar = { fg = c.text, bg = c.surface0 },
            WinBarNC = { fg = c.overlay1, bg = c.mantle },
            CursorColumn = { link = "CursorLine" },
            EndOfBuffer = { fg = c.surface0 },
            Folded = { bg = c.base },
            TreesitterContextBottom = { style = { "underline" }, sp = c.surface0 },
            -- TODO: fix these
            --
            -- TreesitterContextLineNumber = { style = {}, sp = 'none' },

            -- these looks bad in wezterm :(
            -- DiagnosticUnderlineError = { style = { "undercurl" } },
            -- DiagnosticUnderlineHint = { style = { "undercurl" } },
            -- DiagnosticUnderlineInfo = { style = { "undercurl" } },
            -- DiagnosticUnderlineOk = { style = { "undercurl" } },
            -- DiagnosticUnderlineWarn = { style = { "undercurl" } },
          }
        end,
      },
      integrations = {},
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      -- compile catppuccin theme to apply theme change every time
      require("catppuccin").compile()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}

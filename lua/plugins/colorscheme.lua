return {
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "kvrohit/mellow.nvim", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "JoosepAlviste/palenightfall.nvim", lazy = true },
  -- oh-lucy.nvim
  -- nvim-tundra
  -- oxocarbon.nvim
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
            TabLineFill = { fg = c.overlay2, bg = c.crust },
            VertSplit = { fg = winsep },
            StatusLine = { bg = c.surface0 },
            WinBar = { fg = c.text, bg = c.mantle },
            WinBarNC = { fg = c.surface1, bg = c.mantle },
            CursorColumn = { link = "CursorLine" },
            EndOfBuffer = { fg = c.surface0 },
            Folded = { bg = c.base },
            TreesitterContextBottom = { style = { "underline" }, sp = c.surface0 },

            DiagnosticUnderlineError = { style = { "undercurl" } },
            DiagnosticUnderlineHint = { style = { "undercurl" } },
            DiagnosticUnderlineInfo = { style = { "undercurl" } },
            DiagnosticUnderlineOk = { style = { "undercurl" } },
            DiagnosticUnderlineWarn = { style = { "undercurl" } },
            GitSignsChangedelete = { fg = c.blue, style = { "underline" }, sp = c.red },
            ["@text.emphasis"] = { fg = c.text },
            ["@text.strong"] = { fg = c.text },
          }
        end,
      },
      integrations = {
        telescope = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      -- compile catppuccin theme to apply theme change every time
      -- require("catppuccin").compile()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

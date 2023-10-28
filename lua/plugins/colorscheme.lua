return {
  { "ellisonleao/gruvbox.nvim", lazy = true },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      compile = true,
      dimInactive = false,
      terminalColors = true,
      overrides = function(colors)
        local theme = colors.theme
        -- FIX: why this isn't working
        return {
          WinBar = { bg = "white" },
          -- ["@lsp.type.string"] = { link = "@string" },
        }
      end,
      background = {
        dark = "wave",
        light = "lotus",
      },
    },
    config = function(opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")
    end,
  },
  { "kvrohit/mellow.nvim", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "JoosepAlviste/palenightfall.nvim", lazy = true },
  -- oh-lucy.nvim
  -- nvim-tundra
  -- oxocarbon.nvim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- lazy = true,
    opts = {
      transparent_background = true,
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

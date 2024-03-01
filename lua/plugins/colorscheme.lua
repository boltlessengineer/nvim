-- HACK: refactor this shit
return {
  { "ellisonleao/gruvbox.nvim", lazy = true },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      compile = true,
      dimInactive = false,
      terminalColors = true,
      overrides = function(colors)
        local theme = colors.theme
        -- FIX: why this isn't working
        return {
          Winbar = { bg = theme.ui.bg_m3 },
          WinbarNC = { bg = theme.ui.bg_m3 },
          -- ["@lsp.type.string"] = { link = "@string" },
          ["@text.literal"] = { link = "String" },

          -- HACK: quick fix from [kanagawa.nvim#197]
          -- update kanagawa to handle new treesitter highlight captures

          -- ["@variable.parameter"] = { link = "@parameter" },
          -- ["@variable.member"] = { link = "@field" },
          -- ["@module"] = { link = "@namespace" },
          -- ["@number.float"] = { link = "@float" },
          -- ["@string.special.symbol"] = { link = "@symbol" },
          -- ["@string.regexp"] = { link = "@string.regex" },
          -- ["@markup.strong"] = { link = "@text.strong" },
          -- ["@markup.italic"] = { link = "@text.emphasis" },
          -- ["@markup.heading"] = { link = "@text.title" },
          -- ["@markup.raw"] = { link = "@text.literal" },
          -- ["@markup.quote"] = { link = "@text.quote" },
          -- ["@markup.math"] = { link = "@text.math" },
          -- ["@markup.environment"] = { link = "@text.environment" },
          -- ["@markup.environment.name"] = { link = "@text.environment.name" },
          -- ["@markup.link.url"] = { link = "@text.uri" },
          -- ["@markup.link.label"] = { link = "@string.special" },
          -- ["@markup.list"] = { link = "@punctuation.special" },
          -- ["@comment.note"] = { link = "@text.note" },
          -- ["@comment.warning"] = { link = "@text.warning" },
          -- ["@comment.danger"] = { link = "@text.danger" },
          -- ["@diff.plus"] = { link = "@text.diff.add" },
          -- ["@diff.minus"] = { link = "@text.diff.delete" },

          -- personal
          ["@markup.raw.verbatim"] = { fg = "#8a9a7b", bg = "#282727" },
          ["@markup.underline"] = { underline = true },
          ["@markup.strikethrough"] = { strikethrough = true },
          ["@markup.heading.2"] = { link = "@attribute" },
          ["@error"] = { link = "Error" },
          ["CodeBlock"] = { bg = "#282727" },
        }
      end,
      background = {
        dark = "wave",
        light = "lotus",
      },
    },
  },
  { "kvrohit/mellow.nvim", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "JoosepAlviste/palenightfall.nvim", lazy = true },
  -- oh-lucy.nvim
  -- nvim-tundra
  -- oxocarbon.nvim
  {
    "NTBBloodBath/sweetie.nvim",
    lazy = true,
    config = function()
      vim.g.sweetie = {
        pumblend = { enable = false },
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      transparent_background = false,
      term_colors = true,
      highlight_overrides = {
        all = function(c)
          return {
            NonText = { fg = c.surface0 },
            TabLineFill = { fg = c.overlay2, bg = c.crust },
            StatusLine = { bg = c.surface0 },
            WinBar = { fg = c.text, bg = c.mantle },
            StatusLineNC = { fg = c.surface2 },
            WinBarNC = { fg = c.surface2, bg = c.mantle },
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
            NeogitCursorLine = { link = "CursorLine" },
          }
        end,
      },
      integrations = {
        telescope = true,
        neogit = false,
      },
    },
  },
}

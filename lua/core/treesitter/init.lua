local ok, tsconfigs = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

local loved_parsers = require('core.treesitter.parsers')

tsconfigs.setup {
  ensure_installed = loved_parsers,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  playground = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  textobjects = {
    -- TODO: be used to default/configured mappings
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      }
    },
    swap = {},
    move = {},
    lsp_interop = {},
  },
  rainbow = {
    enable = false,
    extended_mode = true,
  },
  -- TODO: fill below
}

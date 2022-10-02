local ok, tsconfigs = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

local loved_parsers = require('core.treesitter.parsers')

tsconfigs.setup {
  ensure_installed = loved_parsers,
  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = false
  },
  context_commentstring = {
    enable = true,
  },
  -- TODO: fill below
}

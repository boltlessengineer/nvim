local ok, lir = pcall(require, 'lir')
if not ok then return end

local actions = require 'lir.actions'

lir.setup {
  show_hidden_files = true,
  devicons_enable = false,
  mappings = {
    ['<CR>'] = actions.edit,

    ['h'] = actions.up,
    ['q'] = actions.quit,

    ['R'] = actions.rename,
  },
}

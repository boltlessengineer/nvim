local ok, telescope = pcall(require, 'telescope')
if not ok then return end

local actions = require 'telescope.actions'

-- TODO: custom help_tag() function to open help page in floating window
-- cause I generally open help page temporarily.
-- open as floating window first, and then set buffer-local keymaps to move buffer to split window

-- TODO: ignore gitcommit file in old_files
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<ESC>'] = actions.close,
        ['<C-c>'] = actions.close,
      },
    },
    -- TODO: this is not enough
    border = not (vim.g.borderstyle == 'none'),
  },
  extensions = {
    file_browser = {
      hijack_netrw = false,
    },
  },
}
require('keymaps.external').telescope()

telescope.load_extension('file_browser')
-- telescope.load_extension('noice')

local ok, trouble = pcall(require, 'trouble')
if not ok then return end

local icons = require('boltless.ui.icons')

trouble.setup {
  icons = true, -- use devicons for filenames
  fold_open = '', -- icon used for open folds
  fold_closed = '', -- icon used for closed folds
  group = true, -- group results by file
  padding = true, -- add an extra new line on top of the list
  -- action_keys = {}, -- key mappings for actions in the trouble list
  signs = {
    error = icons.diagnostics.Error,
    warning = icons.diagnostics.Warning,
    hint = icons.diagnostics.Hint,
    information = icons.diagnostics.Information,
    -- TODO: check where `other` icon used & replace with boltless.ui.icons
    other = '﫠'
  },
  -- TODO: maybe setting this option true is better
  use_diagnostic_signs = false,
}

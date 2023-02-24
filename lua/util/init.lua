local M = {}

function M.float_help(subject, opts)
  opts = vim.tbl_deep_extend("force", {
    size = { width = 0.9, height = 0.9 },
  }, opts or {})
  require('lazy.util').float(opts)
  vim.cmd.help(subject)
end

function M.telescope_float_help()
  require('telescope.builtin').help_tags()
end

return M

local M = {}

M.ignore_buftype = {
  'prompt',
  'nofile',
  'help',
  'quickfix',
}

-- filetypes which are NOT actual files
M.ignore_filetype = {
  'alpha',
  'NvimTree',
  'TelescopePrompt',
  'packer',
  'lspinfo',
  'mason',
  'tsplayground',
}

-- filenames which are NOT actual files in form of `pattern`
M.ignore_filename = {
}

return M

-- TODO: replace this module to vim.g.get_ignore_filetype(), etc
local M = {}

function M.ignore_buftype(more)
  more = more or {}
  return {
    'prompt',
    'nofile',
    'help',
    'quickfix',
    unpack(more),
  }
end

-- filetypes which are NOT actual files
function M.ignore_filetype(more)
  more = more or {}
  return {
    'alpha',
    'NvimTree',
    'TelescopePrompt',
    'packer',
    'lspinfo',
    'mason',
    'tsplayground',
    unpack(more),
  }
end

-- filenames which are NOT actual files in form of `pattern`
function M.ignore_filename(more)
  more = more or {}
  return {
    unpack(more),
  }
end

return M

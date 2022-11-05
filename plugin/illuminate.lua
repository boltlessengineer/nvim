local ok, illuminate = pcall(require, 'illuminate')
if not ok then return end

illuminate.configure {
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  filetypes_denylist = require('boltless.utils.list').ignore_filetype({
    '',
    'txt',
    'help',
    'markdown',
  }),
}

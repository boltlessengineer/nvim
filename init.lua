-- pcall(require, 'impatient')

require('boltless.options')
require('keymaps.basic')
require('autocmds.basic')
require('boltless.globals')

require('boltless.usercmds.basic')
require('boltless.utils.git')

pcall(vim.cmd.colorscheme, 'catppuccin')

-- Mason should be setup before lspconfig
require('plugins.mason')
require('plugins.neodev')
require('plugins.neoconf')

-- Highlighting should run first
require('core.treesitter')
require('core.lsp')

require('plugins.packer')

require('boltless.ui')
-- TODO: [feature] reloading

require('leap').add_default_mappings()

function __get_winbar()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].buftype == 'terminal' then
    return table.concat({
      'terminal',
      -- string.match(vim.fn.expand('%'), '//%d+:(%S+)$'),
      '%=',
      string.format('[%d/%d]', vim.b[bufnr].terminal_index or -1, vim.g.terminal_count or -1)
    })
  end
  return '%f %h%w%m%r %=%(%l,%c%V %= %P%)'
end

vim.o.winbar = '%{%v:lua.__get_winbar()%}'

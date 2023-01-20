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

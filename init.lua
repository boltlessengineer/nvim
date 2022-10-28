-- pcall(require, 'impatient')

require('keymaps.basic')
require('autocmds.basic')
require('boltless.globals')
require('boltless.options')

require('boltless.usercmds.basic')
require('boltless.utils.git')

vim.cmd.colorscheme('catppuccin')
require('boltless.ui')

-- Mason should be setup before lspconfig
require('plugins.mason')

-- Highlighting should run first
require('core.treesitter')
require('core.lsp')

require('plugins.packer')

-- TODO: [feature] reloading

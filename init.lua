require('impatient')

require('core.options')
require('keymaps.basic')
require('autocmds.basic')
require('boltless.globals')

require('boltless.usercmds.basic')
require('boltless.ui')

require('boltless.colorscheme')

-- Mason should be setup before lspconfig
require('plugins.mason')

require('core.lsp')
require('core.treesitter')

require('plugins.packer')

-- TODO: [feature] reloading

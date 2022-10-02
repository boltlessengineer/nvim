vim.cmd.colorscheme('gruvbox')

require('core.options')
require('keymaps.basic')

-- Mason should be setup before lspconfig
require('plugins.mason')

require('core.lsp')
require('core.treesitter')

require('plugins.packer')

require('impatient')

require('core.options')
require('keymaps.basic')
require('autocmds.basic')
require('boltless.globals')

require('boltless.usercmds.basic')
require('boltless.utils.git')

-- require('kanagawa').setup {
--   overrides = {
--     WinBar = { bg = '#000000' },
--   }
-- }
vim.cmd.colorscheme('kanagawa')
require('boltless.ui')

-- Mason should be setup before lspconfig
require('plugins.mason')

-- Highlighting should run first
require('core.treesitter')
require('core.lsp')

require('plugins.packer')

-- TODO: [feature] reloading

if not vim.g.neovide then return end

vim.g.neovide_transparency = 0.0
vim.g.transparency = 0.97
-- TODO: set env $TERM
require('autocmds.external').neovide()
require('keymaps.external').neovide()

vim.cmd.cd '~/.config/nvim'
